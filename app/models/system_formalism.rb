
# TODO Maybe add some descriptions to the relation instances
class SystemFormalism < ActiveRecord::Base
  has_many :pattern_formalisms, :autosave => true, :dependent => :destroy
  has_many :relation_descriptors, :autosave => true, :dependent => :destroy


  validate  :must_have_exactly_two_unalterable_relation_descriptors
  validates_presence_of :author, :name, :version
  validates_uniqueness_of :name

  def must_have_exactly_two_unalterable_relation_descriptors
     errors.add_to_base("Invalid number of unalterable relation descriptors") \
      unless relation_descriptors.select{|rel| !rel.is_alterable}.size == 2
  end

  def after_initialize
    if self.relation_descriptors.empty?
      self.relation_descriptors.build({:name => 'Use', :is_reflexive => true, :is_alterable => false})
      self.relation_descriptors.build({:name => 'Require', :is_reflexive => false, :is_alterable => false})
    end
  end

end
