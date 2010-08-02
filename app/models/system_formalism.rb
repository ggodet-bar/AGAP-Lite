
# TODO Maybe add some descriptions to the relation instances
class SystemFormalism < ActiveRecord::Base
  has_many :pattern_formalisms, :autosave => true, :dependent => :destroy
  has_many :relation_descriptors, :autosave => true, :dependent => :destroy
  has_many :field_descriptors, :autosave => true, :dependent => :destroy


  validate  :must_have_exactly_two_unalterable_relation_descriptors
  validates_presence_of :author, :name, :version
  validates_uniqueness_of :name

  after_initialize :create_default_relation_descriptors
  before_save :update_field_descriptor_indexes

  def must_have_exactly_two_unalterable_relation_descriptors
     errors[:base] << "Invalid number of unalterable relation descriptors" \
      unless relation_descriptors.select{|rel| !rel.is_alterable}.size == 2
  end

  def create_default_relation_descriptors
    if self.relation_descriptors.empty?
      self.relation_descriptors.build({:name => 'Use', :is_reflexive => true, :is_alterable => false})
      self.relation_descriptors.build({:name => 'Require', :is_reflexive => false, :is_alterable => false})
    end
  end

  def update_field_descriptor_indexes
    self.field_descriptors.each_with_index do |field, i|
      field.index = 100 + i # System formalism field descriptors are, by default, the last elements
    end
  end
end
