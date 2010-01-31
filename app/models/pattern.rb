class Pattern < ActiveRecord::Base
  belongs_to :pattern_system
  belongs_to :pattern_formalism
  has_many :classification_selections, :dependent => :destroy
  accepts_nested_attributes_for :classification_selections, :reject_if => lambda {|a| a[:classification_element_id].blank?}, :allow_destroy => true
  has_many :string_instances, :dependent => :destroy
  accepts_nested_attributes_for :string_instances, :reject_if => lambda {|a| a[:content].blank?}
  has_many  :text_instances, :dependent => :destroy
  accepts_nested_attributes_for :text_instances, :reject_if => lambda {|a| a[:content].blank?}

  # Temporary?
  has_one     :image_association
  has_one     :mappable_image, :through => :image_association

  validates_presence_of :name
end
