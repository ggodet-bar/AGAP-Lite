class MappableImage < ActiveRecord::Base
  belongs_to  :pattern_system
  belongs_to  :field_descriptor
    
  
  if RAILS_ENV == "production"
    has_attached_file :image,
                    :style => {:medium => "700x800>"},
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":pattern_system/:basename.:extension",
                    :url => ':s3_domain_url',
                    :s3_protocol => 'http',
                    :s3_permissions => 'public-read-write'
                    
  else if %w(test development cucumber).include? RAILS_ENV
      has_attached_file :image,
                    :styles => {:medium => "700x800>"},
                    :url => "/images/:pattern_system/:basename.:extension",
                    :path => ":rails_root/public/images/:pattern_system/:basename.:extension"
      end
  end

  after_create :save_dimensions

  Paperclip.interpolates :pattern_system do |attachment, style|
    attachment.instance.pattern_system.short_name
  end

  def save_dimensions
    if ["image/jpeg", "image/tiff", "image/png", "image/gif", "image/bmp"].include?(image.content_type)
      self.image_width = image.width(:medium)
      self.image_height = image.height(:medium)
      self.save(false)
   end
  end
  
end
