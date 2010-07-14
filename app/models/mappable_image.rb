class MappableImage < ActiveRecord::Base
  belongs_to  :pattern_system
    
  
  if Rails.env.production?
    has_attached_file :image,
                    :style => {:medium => "700x800>"},
                    :storage => :s3,
                    :s3_credentials => Rails.root.join("config", "s3.yml").to_s,
                    :path => ":pattern_system/:basename.:extension",
                    :url => ':s3_domain_url',
                    :s3_protocol => 'http',
                    :s3_permissions => 'public-read-write'
                    
  else if %w(test development cucumber).include? Rails.env
      has_attached_file :image,
                    :styles => {:medium => "700x800>"},
                    :url => "/images/:pattern_system/:basename.:extension",
                    :path => ":rails_root/public/images/:pattern_system/:basename.:extension"
      end
  end

  after_save :save_dimensions

  Paperclip.interpolates :pattern_system do |attachment, style|
    attachment.instance.pattern_system.short_name
  end

  def save_dimensions
    if self.image_width.blank? && self.image_height.blank? && ["image/jpeg", "image/tiff", "image/png", "image/gif", "image/bmp"].include?(image.content_type)
      self.image_width = image.width(:medium)
      self.image_height = image.height(:medium)
      self.save(:validate => false)
   end
  end
  
end
