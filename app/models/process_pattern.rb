class ProcessPattern < ActiveRecord::Base
  
  belongs_to  :pattern_system
  has_one     :image_association
  has_one     :mappable_image, :through => :image_association
  has_many    :maps, :through  => :mappable_image
  has_and_belongs_to_many :participants, :class_name  => "Participant", :join_table => "participations", :foreign_key => "process_pattern_id", :association_foreign_key  => "participant_id"
  has_and_belongs_to_many :use_patterns, :class_name => "ProcessPattern", :join_table => "use_patterns", :foreign_key => "source_pattern_id", :association_foreign_key => "target_pattern_id"
  has_and_belongs_to_many :context_patterns, :class_name  => "ProcessPattern", :join_table => "context_patterns", :foreign_key => "source_pattern_id", :association_foreign_key  => "target_pattern_id"

  # New generic relation type
  has_many  :relations, :foreign_key => 'source_pattern_id'
  has_many  :related_patterns, :through => :relations, :as => :target_pattern

      
  # Defines the indexes that will be searched with
  # thinking_sphinx
#  define_index do
#    indexes author
#    indexes :name, :sortable => true
#    indexes process_solution
#    indexes problem
#    indexes forces
#    indexes product_solution
#    indexes application_case
#    indexes application_consequence
#    
#    has pattern_system_id
#  end
               
  # Returns the list of ancestors of current pattern (which is not included in the list).
  # The ancestors are ordered from the root of the pattern system down to the most immediate pattern
  # (provided that the processContext attribute was correctly filled).             
  def ancestors
    explored_pattern = context_patterns.first
    ancestors = []
    until explored_pattern.nil? do
      ancestors << explored_pattern
      context_patterns_list = explored_pattern.context_patterns
      if context_patterns_list.nil?
        explored_pattern = nil
      else
        explored_pattern = context_patterns_list.first
      end
    end 
    
    ancestors.reverse
  end

protected
  def validate
    errors.add_on_empty %w( name  author  )
    # NB The current pattern is not yet saved in the DB, so we need to check if there is ONE other pattern with the same name
    is_valid = true
    existing_pat = ProcessPattern.where(:name => attributes['name']).all - Array(self)
    existing_pat.each do |pat| 
      is_valid &= pat.pattern_system.nil? || pat.pattern_system.id != attributes['pattern_system_id']
    end unless existing_pat.blank?
    errors.add(:name, :taken) unless is_valid
  end
end
