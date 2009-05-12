class PatternSystem < ActiveRecord::Base
  has_many  :process_patterns, :dependent  => :destroy
  has_many  :product_patterns
  has_many  :participants, :dependent  => :destroy
  has_many  :mappable_images, :dependent => :destroy
  has_one   :root_pattern, :class_name => "ProcessPattern", :conditions => ["is_root_pattern = ?", true]
  
  validates_presence_of :author, :name, :short_name
  validates_uniqueness_of :name
  validates_uniqueness_of :short_name
  
  def root_pattern=(pattern)
    PatternSystem.transaction do
      process_patterns.each{ |pat|  
        pat.update_attributes({:is_root_pattern =>  false})}
      pattern.update_attributes({:is_root_pattern =>  true})
    end
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
    
    # for each participant in the system, store its reference and name
    participant_ref = {}
    participants.each{ |participant|  participant_ref[participant.id] = participant.name}
    
    # clone all the participants in the new system
    new_system.participants = participants.collect{ |participant| participant.clone }
    
    # for each image in the old system, we store its public filename and the new image's public filename
    image_ref = {}    
    # clone all the images in the new system (N.B the pattern system should be saved before the images, in order to validate
    # the new folder name)
    new_system.mappable_images = mappable_images.collect{ |image| image.clone }
    did_save_images = true
    new_system.mappable_images.each{ |image| 
      image.pattern_system = new_system
      did_save_images &= image.save
      
      # for each image, copy the old location to the new, using the same id partioning algorithm as attachment_fu
      FileUtils.mkdir_p File.join RAILS_ROOT, '/public/images', new_system.short_name, ("%08d" % image.id).scan(/..../)
      old_path = File.join RAILS_ROOT, '/public/', self.mappable_images.select{|old_image| old_image.filename == image.filename}.first.public_filename
      new_path = File.join RAILS_ROOT, '/public/images/', new_system.short_name, ("%08d" % image.id).scan(/..../), image.filename
      
      image_ref[old_path] = new_path
      
      logger.debug "Copying file with path : " + old_path + " to : " + new_path
      FileUtils.cp_r old_path, new_path
      }
    
    unless did_save_images
        debug.error "Could not clone mappable_images"
        raise "Could not clone system"
    end

    # clone all the patterns in the new system
    new_patterns = []
    new_system.process_patterns = process_patterns.collect{ |pattern| pattern.clone}
    
    successful_saves = true
    new_system.process_patterns.each{|pattern| 
      pattern.pattern_system = new_system
      successful_saves &= pattern.save
      # unless pattern.errors.blank?
      #   puts pattern.pattern_system.short_name
      #   puts pattern.pattern_system.id
      #   puts pattern.name
      #   puts pattern.errors.full_messages
      # end
        }
    
    unless successful_saves
      debug.error "Could not clone process_patterns"
      raise "Could not clone system"
    end
    
    # We convert the root pattern of the system
    unless root_pattern.blank?
      new_system.root_pattern = new_system.process_patterns.select{ |pat| pat.name == root_pattern.name }.first
    end
    
    # We convert the references of the context patterns
    process_patterns.each{ |pattern|
      unless pattern.context_patterns.blank?
        pattern.context_patterns.each{ |old_cont_pat|
            # Get the corresponding context pattern
            new_cont_pat = new_system.process_patterns.select{ |the_pat|  the_pat.name == old_cont_pat.name}.first
            
            # Get the pattern from the new system
            new_pat = new_system.process_patterns.select{ |new_pat| new_pat.name == pattern.name}.first
            new_pat.context_patterns << new_cont_pat
        }
      end
    }
    unless new_system.valid?
      raise "Could not clone system"
    end
    new_system
  end
  end
end
