require 'nokogiri'

class PatternSystem < ActiveRecord::Base
  has_many  :process_patterns, :dependent  => :destroy
  has_many  :product_patterns
  has_many  :participants, :dependent  => :destroy
  has_many  :mappable_images, :dependent => :destroy
  
  validates_presence_of :author, :name, :short_name
  validates_uniqueness_of :name
  validates_uniqueness_of :short_name

  @registered_relations = [{:type => :requires, :is_reflexive => false}, 
    {:type => :refines, :is_reflexive => false}, 
    {:type => :alternative, :is_reflexive => true}, 
    {:type => :uses, :is_reflexive =>false}]
    
  # Temporary hack!
  def registered_relations
    @registered_relations
  end
  
  def registered_relations=(relations)
    @registered_relations = relations
  end
  
  def root_pattern=(pattern)
    PatternSystem.transaction do
      process_patterns.each{ |pat|  
        pat.update_attributes({:is_root_pattern =>  false})
      }
      ProcessPattern.find(pattern).update_attributes({:is_root_pattern =>  true})
    end unless pattern.blank? || pattern == "[\"\"]"
  end
  
  def root_pattern
    patterns = process_patterns.select{ |pat| pat.is_root_pattern}
    ProcessPattern.find(patterns.first) unless patterns.empty?
  end
  
  def to_param
    "#{short_name}"
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
          FileUtils.mkdir_p( File.join(RAILS_ROOT, '/public/images', new_system.short_name, ("%08d" % image.id).scan(/..../)))
          old_path            = File.join RAILS_ROOT, '/public/', self.mappable_images.select{|old_image| old_image.filename == image.filename}.first.public_filename
          new_path            = File.join RAILS_ROOT, '/public/images/', new_system.short_name, ("%08d" % image.id).scan(/..../), image.filename

          image_ref[image.filename] = File.join '../../../../images/', new_system.short_name, ("%08d" % image.id).scan(/..../), image.filename

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
