# encoding : UTF-8

require 'nokogiri'

class PatternSystem < ActiveRecord::Base
  
  has_many  :classification_elements, :dependent => :destroy
  accepts_nested_attributes_for :classification_elements, :reject_if => lambda {|a| a[:name].blank?}, :allow_destroy => true
  has_many :patterns, :dependent => :destroy

  has_many  :mappable_images, :dependent => :destroy
  belongs_to :system_formalism
  
  validates_presence_of :author, :name, :short_name, :system_formalism
  validates_uniqueness_of :name
  validates_uniqueness_of :short_name

  def to_param
    "#{short_name}"
  end

  def structured_pattern_list
    # Looking for a means to classify patterns
    if system_formalism.pattern_formalisms.count > 1
      # Then we look for a main pattern
      main_pattern = system_formalism.pattern_formalisms.select{|p| p.is_main_pattern}.first
    end 
    main_pattern = main_pattern.blank? ? system_formalism.pattern_formalisms.first : main_pattern
    
    # We get the first relation type that is used for sorting patterns
    main_relation = system_formalism.relation_descriptors.select{|r| r.is_sorting}.first

    # We create a patterns list based on the pattern formalism names
    patterns_list = system_formalism.pattern_formalisms.inject({}) do |acc, p|
      sub_patterns_list = patterns.select{|a| a.pattern_formalism == p}
      acc[p.name] = order_patterns(sub_patterns_list, main_relation)
      acc
    end

    # We look for a main field type
    main_field = main_pattern.field_descriptors.select{|f| f.is_sorting_patterns}.first

    unless main_field.blank?
      classif_elements = classification_elements.select{|c| c.field_descriptor_id == main_field.id}
      patterns_list = classif_elements.inject({}) do |acc, c|
        acc[c.name] = [{:node => nil, :children => patterns.select{|p| p.classification_selections.any?{|sel| sel.classification_element_id == c.id}}.map(&:id)}, []]
        acc
      end

      unordered_patterns = patterns.map(&:id) - patterns_list.values.collect{|l| l[0][:children]}.flatten.uniq
      unless unordered_patterns.empty?
        patterns_list["Unordered patterns"] = [{:node => nil, :children => unordered_patterns}, []]
      end
    end


    patterns_list
  end

  # This method tries to create a tree structure, based on the relations
  # between patterns. Returns a list of sub-trees if not all patterns are
  # related.
  #
  # Returns an Array of two elements, the first one being the result of
  #   pattern ordering algorithm, the second one the remaining (unordered)
  #   patterns.
  #
  def order_patterns(patterns_list, sort_relation)
    existing_relations = Relation.where(:relation_descriptor_id => sort_relation.id) \
                                 .where({:source_pattern_id => patterns_list.map(&:id)}) \
                                 .where({:target_pattern_id => patterns_list.map(&:id)})
    edges = existing_relations.collect{|rel| [rel.source_pattern_id, rel.target_pattern_id]}

    complete_graphs = Grapher::identify_complete_subgraphs(edges).sort_by{|graph| graph.size}

    flattened_graphs = complete_graphs.dup
    ordered_patterns = flattened_graphs.shift.flatten.uniq
    unordered_patterns = patterns.map(&:id) - ordered_patterns

    if complete_graphs.empty?
      [nil, unordered_patterns]
    else
      [Grapher::treeify_complete_graph(complete_graphs.first), unordered_patterns]
    end

  end

  def clone_with(name = nil, short_name = nil, author = nil)
    PatternSystem.transaction do
      new_system = clone

      new_system.name = name unless name.nil?
      new_system.short_name = short_name unless short_name.nil?
      new_system.author = author unless author.nil?

      new_system.update_field = ""

      unless new_system.save
        logger.error "Could not save the basic pattern system"
        logger.error new_system.errors.full_messages
        raise "Could not clone system"
      end

      # clone all the participants in the new system
      new_system.participants = participants.collect{ |participant| participant.clone }

      # for each image in the old system, we store its public filename and the new image's public filename
      image_ref = {}    
      # clone all the images in the new system (N.B the pattern system should be saved before the images, in order to validate
      # the new folder name)
      new_system.mappable_images = mappable_images.collect{ |image| image.clone }
      new_system.mappable_images.each{ |image| 
        image.pattern_system = new_system
        
        if image.save
          # for each image, copy the old location to the new, using the same id partitioning algorithm as attachment_fu
          FileUtils.mkdir_p( Rails.root.join('public', 'images', new_system.short_name, ("%08d" % image.id).scan(/..../)))
          old_path            = Rails.root.join('public', self.mappable_images.select{|old_image| old_image.filename == image.filename}.first.public_filename)
          new_path            = Rails.root.join('public', 'images', new_system.short_name, ("%08d" % image.id).scan(/..../), image.filename)

          image_ref[image.filename] = Rails.root.join 'public', 'images', new_system.short_name, ("%08d" % image.id).scan(/..../), image.filename

          logger.debug "Copying file with path : " + old_path + " to : " + new_path
          FileUtils.cp_r old_path, new_path
        else
          logger.error "Could not clone mappable_images: #{image.filename}"
          raise "Could not clone system"
        end

      }

      # clone all the patterns in the new system
      new_patterns = []
      new_system.process_patterns = process_patterns.collect{ |pattern| pattern.clone}

      # TODO Update the reference to the image solution

      new_system.process_patterns.each{|pattern| 
        # Update the reference to the parent pattern system
        pattern.pattern_system = new_system
        
        # Get the origin
        origin = self.process_patterns.select{|old_pattern| old_pattern.name == pattern.name}.first
        # Update the new pattern with its mappable_image
        unless origin.mappable_image.blank?
          old_image = origin.mappable_image
          new_image = new_system.mappable_images.select{|image| image.filename == old_image.filename}.first
          pattern.mappable_image = new_image
        end
        
        # Update the references to images in text fields
        pattern.attributes.each_key{ |key|  
          if pattern.attributes[key].class == String
              pattern.attributes = {key => convert_image_references(image_ref, pattern.attributes[key])}
              logger.debug "The attribute #{key} now holds #{pattern.attributes[key]}"
          end
        }
        
        unless pattern.save
          logger.error "Could not clone process_patterns: #{pattern.name}"
          raise "Could not clone system"
        end
      }

      # We convert the root pattern of the system
      unless root_pattern.blank?
        new_system.root_pattern = new_system.process_patterns.select{ |pat| pat.name == root_pattern.name }.first
      end

      convert_pattern_references(new_system, "context_patterns")
      convert_pattern_references(new_system, "use_patterns")

      unless new_system.save
        raise "Could not clone system"
      end
      new_system
    end
  end


private

  def convert_pattern_references(new_pattern_system, attribute_name)
    logger.info "Converting pattern references for the #{attribute_name} attribute"
    
    self.process_patterns.each{ |pattern|

        unless pattern.send(attribute_name).blank?
          logger.debug "#{pattern.send(attribute_name).size} pattern(s) should be converted"
          pattern.send(attribute_name).each{ |old_attr_pat|
              
              # Get the target pattern from the old and then new pattern system
              new_attr_pat = new_pattern_system.process_patterns.select{ |the_pat|  the_pat.name == old_attr_pat.name}.first
              
              # Get the pattern into which the target pattern will be saved
              new_pat = new_pattern_system.process_patterns.select{ |the_pat|  the_pat.name == pattern.name}.first
              if new_pat.send(attribute_name).nil?
                new_pat.attributes = {attribute_name => []}
              end
              new_pat.attributes =  {attribute_name  => new_pat.send(attribute_name) << new_attr_pat}
              logger.debug "The attributes of pattern #{new_pat.name}: #{new_pat.send(attribute_name)}"
            }
        end
    }
  end
  
  def convert_image_references(image_ref_hash, text)
    if text.blank? || text.strip.empty?
      logger.debug "Text was blank!"
      return text
    else
      logger.debug "Text was ok, class is: #{text.class} and size is #{text.strip.length.to_s}"
    end
        
    unless text.include?('<') && text.include?('>')
      return text # That is, the text was only a string (and did not contain html tags)
    end
    
    
    doc = Nokogiri::HTML(text)
    if doc.nil?
      logger.error "Could not create an HTML fragment."
      raise "Could not clone system"
    end

    doc.xpath('//img').each{|node|
      image_ref_hash.each_key{ |key| 
        logger.debug "We are looking at key: #{key} and node with src: #{node['src']}"
        if node['src'].include? key
          logger.debug "The current source is replaced with #{image_ref_hash[key]}"
          node['src'] = image_ref_hash[key]
        end
      }
    }
    doc.root.child.inner_html
  end
end
