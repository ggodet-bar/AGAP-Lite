class Relation < ActiveRecord::Base
  belongs_to :source_pattern, :class_name => 'Pattern', :foreign_key => "source_pattern_id"
  belongs_to :target_pattern, :class_name => 'Pattern', :foreign_key => "target_pattern_id"
  belongs_to :relation_descriptor

  after_create do |relation|
    if relation_descriptor.is_reflexive &&
      Relation.where(:source_pattern_id => target_pattern_id) \
              .where(:target_pattern_id => source_pattern_id) \
              .where(:relation_descriptor_id => relation_descriptor_id) \
              .empty?
      Relation.create({
        :source_pattern_id => target_pattern_id,
        :target_pattern_id => source_pattern_id,
        :relation_descriptor_id => relation_descriptor_id
      })
    end
  end

  after_destroy do |relation|
    if relation_descriptor.is_reflexive
      reflexive_relation = Relation.where(:source_pattern_id => target_pattern_id) \
                                   .where(:target_pattern_id => source_pattern_id) \
                                   .where(:relation_descriptor_id => relation_descriptor_id)
      if reflexive_relation.present?
        reflexive_relation.map(&:destroy)
      end
    end
  end

end
