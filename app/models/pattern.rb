class Pattern < ActiveRecord::Base
  belongs_to :pattern_system
  belongs_to :pattern_formalism
  has_many :classification_selections, :dependent => :destroy
  accepts_nested_attributes_for :classification_selections, :reject_if => lambda {|a| a[:classification_element_id].blank?}, :allow_destroy => true
  has_many :string_instances, :dependent => :destroy
  accepts_nested_attributes_for :string_instances, :reject_if => lambda {|a| a[:content].blank?}
  has_many  :text_instances, :dependent => :destroy
  accepts_nested_attributes_for :text_instances, :reject_if => lambda {|a| a[:content].blank?}

  has_many     :image_associations, :dependent => :destroy
  accepts_nested_attributes_for :image_associations, :reject_if => lambda {|a| a[:mappable_imaege_id].blank? || a[:pattern_id].blank?}
  has_many     :mappable_images, :through => :image_associations
  has_many    :maps, :dependent => :destroy
  accepts_nested_attributes_for :maps, :reject_if => lambda {|a| a[:x_corner].blank?}, :allow_destroy => true

  has_many  :relations, :dependent => :destroy, :foreign_key => 'source_pattern_id'
  validates_presence_of :name
end
