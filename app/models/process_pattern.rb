class ProcessPattern < ActiveRecord::Base
  validates_presence_of :name
  
  belongs_to  :pattern_system
  has_one     :mappable_image
  # has_many    :participants, :through => :participations
  # has_many      :participations
  has_and_belongs_to_many :participants, :class_name  => "Participant", :join_table => "participations", :foreign_key => "process_pattern_id", :association_foreign_key  => "participant_id"
  has_and_belongs_to_many :use_patterns, :class_name => "ProcessPattern", :join_table => "use_patterns", :foreign_key => "source_pattern_id", :association_foreign_key => "target_pattern_id"
  has_and_belongs_to_many :context_patterns, :class_name  => "ProcessPattern", :join_table => "context_patterns", :foreign_key => "source_pattern_id", :association_foreign_key  => "target_pattern_id"
  
  @@fields_dispatch = { :external => ['identifier', 'author'],
                        :interface => ['participant', 'classification', 'processContext', 'productContext', 'problem', 'forces'],
                        :solution => ['process_image_id', 'process_model_url', 'process_solution', 'product_solution'],
                        :relations => ['uses', 'requires', 'alternative']}
end
