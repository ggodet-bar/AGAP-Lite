class Relation < ActiveRecord::Base
  belongs_to :source_pattern, :class_name => 'Pattern', :foreign_key => "source_pattern_id"
  belongs_to :target_pattern, :class_name => 'Pattern', :foreign_key => "target_pattern_id"
  belongs_to :relation_descriptor
end
