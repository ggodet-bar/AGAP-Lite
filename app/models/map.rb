class Map < ActiveRecord::Base
  belongs_to :image_association
  belongs_to :relation

  def color_code
    if relation
      self.relation.relation_descriptor.color_code
    else
      ""
    end
  end

  def color_code= (param)

  end
end
