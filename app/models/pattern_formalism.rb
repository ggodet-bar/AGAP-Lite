class PatternFormalism < ActiveRecord::Base
  has_many :field_descriptors, :autosave => true, :dependent => :destroy
  belongs_to :system_formalism

  # TODO Define the different field types!
  FORMALISM_SECTIONS = %w( interface solution )

  validate :must_have_base_field_descriptors, :all_fields_must_be_in_a_valid_section

  def must_have_base_field_descriptors
    errors.add_to_base("Invalid base field descriptors") \
      unless  self.field_descriptors.any?{|fie| fie.name == "Problem"} &&
              self.field_descriptors.any?{|fie| fie.name == "Participants"}
  end 

  def all_fields_must_be_in_a_valid_section
    errors.add_to_base("Invalid field sections") \
      unless self.field_descriptors.all{|field| FORMALISM_SECTIONS.include?(field.section)}
  end

  def after_initialize 
    if self.field_descriptors.empty?
      self.field_descriptors.build({:name => "Problem", :section => 'interface', :field_type => 'text', :is_alterable => false, :description => "Problem that is addressed by the pattern"})
      self.field_descriptors.build({:name => "Participants", :section => 'interface', :field_type => 'multi_classification', :is_alterable => false, :description => "The personas involved in the realisation of the pattern's solution"})
    end
  end

  # The field descriptors should not be saved directly, but
  # should use the autosave feature of the PatternFormalism
  # model
  def before_save
    # Update the index value in the attributes list
    (1..self.field_descriptors.size).each do |i|
      self.field_descriptors[i-1].index = i
    end
  end

end
