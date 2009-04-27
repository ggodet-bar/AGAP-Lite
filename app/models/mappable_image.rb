class MappableImage < ActiveRecord::Base
  has_many :maps, :dependent  => :destroy
  has_many :image_associations
  belongs_to  :pattern_system
    
  has_attachment  :storage => :file_system, 
                  :max_size => 1.megabytes,
                  :path_prefix  => "public/images",
                  :resize_to  => "800x",
                  :thumbnails => { :thumb => '80x80>', :tiny => '40x40>' },
                  :processor => :MiniMagick # attachment_fu looks in this order: ImageScience, Rmagick, MiniMagick

  validates_as_attachment
  
  def full_filename(thumbnail = nil)
    file_system_path = (thumbnail ? thumbnail_class : self).attachment_options[:path_prefix].to_s
    File.join(RAILS_ROOT, file_system_path, self.pattern_system.short_name, *partitioned_path(thumbnail_name_for(thumbnail)))
    # if thumbnail.blank? && self.thumbnail.blank?
    #   File.join(RAILS_ROOT, file_system_path, 'fullsize', *partitioned_path(thumbnail_name_for(thumbnail)))
    # else
    #   File.join(RAILS_ROOT, file_system_path, 'thumb', *partitioned_path(thumbnail_name_for(thumbnail)))
    # end
  end
  
end