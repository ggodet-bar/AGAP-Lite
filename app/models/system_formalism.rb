class SystemFormalism < ActiveRecord::Base
  has_many :pattern_formalisms, :autosave => true
  has_many :relation_descriptors, :autosave => true


  validate  :must_have_exactly_two_unalterable_relation_descriptors
  validates_presence_of :author, :name, :version
  validates_uniqueness_of :name

  def must_have_exactly_two_unalterable_relation_descriptors
     errors.add_to_base("Invalid number of unalterable relation descriptors") \
      unless relation_descriptors.select{|rel| !rel.is_alterable}.size == 2
  end

  def after_initialize
    relation_descriptors << RelationDescriptor.new({:name => 'use', :is_reflexive => true, :is_alterable => false, :system_formalism_id => id})
    relation_descriptors << RelationDescriptor.new({:name => 'require', :is_reflexive => true, :is_alterable => false, :system_formalism_id => id})
  end

end
