class ProcessPattern < ActiveRecord::Base
  validates_presence_of :name, :author
  validates_uniqueness_of :name, :scope => :pattern_system_id
  
  belongs_to  :pattern_system
  has_one     :mappable_image, :dependent => :destroy
  has_many    :maps, :through  => :mappable_image
  has_and_belongs_to_many :participants, :class_name  => "Participant", :join_table => "participations", :foreign_key => "process_pattern_id", :association_foreign_key  => "participant_id"
  has_and_belongs_to_many :use_patterns, :class_name => "ProcessPattern", :join_table => "use_patterns", :foreign_key => "source_pattern_id", :association_foreign_key => "target_pattern_id"
  has_and_belongs_to_many :context_patterns, :class_name  => "ProcessPattern", :join_table => "context_patterns", :foreign_key => "source_pattern_id", :association_foreign_key  => "target_pattern_id"
  
  @@fields_dispatch = { :external => ['identifier', 'author'],
                        :interface => ['participant', 'classification', 'processContext', 'productContext', 'problem', 'forces'],
                        :solution => ['process_image_id', 'process_model_url', 'process_solution', 'product_solution'],
                        :relations => ['uses', 'requires', 'alternative']}
               
  # Return the list of ancesters of current pattern (which is not included in the list).
  # The ancesters are ordered from the root of the pattern system down to the most immediate pattern
  # (provided that the processContext attribute was correctly filled).             
  def ancesters
    explored_pattern = ProcessPattern.find(context_patterns).first
    ancesters = []
    until explored_pattern.nil? do
      ancesters << ProcessPattern.find(explored_pattern)
      context_patterns_list = explored_pattern.context_patterns
      if context_patterns_list.nil?
        explored_pattern = nil
      else
        explored_pattern = context_patterns_list.first
      end
    end 
    
    ancesters.reverse
  end
end
