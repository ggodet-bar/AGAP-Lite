class PatternFormalism < ActiveRecord::Base
  has_many :field_descriptors, :autosave => true, :dependent => :destroy
  accepts_nested_attributes_for :field_descriptors, :reject_if => lambda{|a| a[:name].blank?}, :allow_destroy => true
  belongs_to :system_formalism

  FORMALISM_SECTIONS = %w( interface solution )

  validates_presence_of :name
  validate :must_have_base_field_descriptors, :all_fields_must_be_in_a_valid_section
  after_initialize :add_default_field_descriptors
  before_save :update_field_descriptor_indexes

  def must_have_base_field_descriptors
    errors[:base] << "Invalid base field descriptors" \
      unless  self.field_descriptors.any?{|fie| fie.name == "Problem"}
  end 

  def all_fields_must_be_in_a_valid_section
    errors[:base] << "Invalid field sections" \
      unless self.field_descriptors.all{|field| FORMALISM_SECTIONS.include?(field.section)}
  end

  def add_default_field_descriptors 
    if self.field_descriptors.empty?
      self.field_descriptors.build({:name => "Problem", :section => 'interface', :field_type => 'text', :is_alterable => false, :description => "Problem that is addressed by the pattern"})
    end
  end

  # The field descriptors should not be saved directly, but
  # should use the autosave feature of the PatternFormalism
  # model
  def update_field_descriptor_indexes
    # Update the index value in the attributes list
    self.field_descriptors.each_with_index do |field, i|
      field.index = i + 1
    end
  end

  # Returns parallel arrays that include the field descriptors
  def fields
    (self.field_descriptors + (self.system_formalism.field_descriptors || [])).partition{|field| field.section == 'interface'}
  end
end
