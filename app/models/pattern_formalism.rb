class PatternFormalism < ActiveRecord::Base
  has_many :field_descriptors, :autosave => true
  belongs_to :system_formalism

  # TODO Define the different field types!
  $FORMALISM_SECTIONS = %w( interface solution )

  validate :must_have_base_field_descriptors

  def must_have_base_field_descriptors
    errors.add_to_base("Invalid base field descriptors") \
      unless  field_descriptors.any?{|fie| fie.name = "name"} &&
              field_descriptors.any?{|fie| fie.name = "problem"}
  end 

  def after_initialize
    field_descriptors << FieldDescriptor.new({:name => 'name', :section => 'interface', :index => 0, :type => 'string', :pattern_formalism_id => id})

    # TODO Maybe set some more default attributes, such as the index
    field_descriptors << FieldDescriptor.new({:name => 'problem', :section => 'interface', :pattern_formalism_id => id})

  end
end
