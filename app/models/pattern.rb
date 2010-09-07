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
  accepts_nested_attributes_for :image_associations, :reject_if => lambda {|a| a[:field_descriptor_id].blank? || a[:mappable_image_id].blank?}, :allow_destroy => true
  has_many     :mappable_images, :through => :image_associations

  has_many  :relations, :dependent => :destroy, :foreign_key => 'source_pattern_id'
  accepts_nested_attributes_for :relations, :reject_if => lambda{|a| a['target_pattern_id'].blank?}, :allow_destroy => true

  validates_presence_of :name


  # Returns a parallel array of instances for each field
  # described by the pattern formalism
  def field_instances
    interface_fields, solution_fields = self.pattern_formalism.fields

    # We get the first non nil instance that corresponds to the field id
    muster = lambda do |field| 
      self.string_instances.select{|a| a.field_descriptor_id == field.id}.first ||
      self.text_instances.select{|a| a.field_descriptor_id == field.id}.first  ||
      self.image_associations.select{|a| a.field_descriptor_id == field.id}.map(&:mappable_image).first ||
      self.classification_selections.select{|a| !a.classification_element.blank? && a.classification_element.field_descriptor_id == field.id} 
    end

    [interface_fields, solution_fields].map{|f| f.map(&muster)}
  end

end
