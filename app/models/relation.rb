class Relation < ActiveRecord::Base
  belongs_to  :source_pattern, :class_name => 'ProcessPattern'
  belongs_to    :target_pattern, :class_name => 'ProcessPattern'
end
