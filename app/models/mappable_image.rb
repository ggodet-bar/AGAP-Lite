class MappableImage < ActiveRecord::Base
  has_many :maps
  belongs_to  :process_pattern
  
  has_attachment  :storage => :file_system, 
                  :max_size => 1.megabytes,
                  :path_prefix  => "public/images",
                  :resize_to  => "800x",
                  :thumbnails => { :thumb => '80x80>', :tiny => '40x40>' },
                  :processor => :MiniMagick # attachment_fu looks in this order: ImageScience, Rmagick, MiniMagick

  validates_as_attachment
end
