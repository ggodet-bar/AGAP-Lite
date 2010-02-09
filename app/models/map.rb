class Map < ActiveRecord::Base
  belongs_to :image_association
  belongs_to :relation
end
