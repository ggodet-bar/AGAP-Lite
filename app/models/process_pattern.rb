class ProcessPattern < ActiveRecord::Base
  
  belongs_to  :pattern_system
  has_one     :image_association
  has_one     :mappable_image, :through => :image_association
  has_many    :maps, :through  => :mappable_image
  has_and_belongs_to_many :participants, :class_name  => "Participant", :join_table => "participations", :foreign_key => "process_pattern_id", :association_foreign_key  => "participant_id"
  has_and_belongs_to_many :use_patterns, :class_name => "ProcessPattern", :join_table => "use_patterns", :foreign_key => "source_pattern_id", :association_foreign_key => "target_pattern_id"
  has_and_belongs_to_many :context_patterns, :class_name  => "ProcessPattern", :join_table => "context_patterns", :foreign_key => "source_pattern_id", :association_foreign_key  => "target_pattern_id"

  # New generic relation type
  # has_and_belongs_to_many :related_patterns,
  #   :class_name => "ProcessPattern",
  #   :foreign_key => "source_pattern_id",
  #   :association_foreign_key => "target_pattern_id",
  #   :join_table => "relations"
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
    explored_pattern = ProcessPattern.find(context_patterns).first
    ancestors = []
    until explored_pattern.nil? do
      ancestors << ProcessPattern.find(explored_pattern)
      context_patterns_list = explored_pattern.context_patterns
      if context_patterns_list.nil?
        explored_pattern = nil
      else
        explored_pattern = context_patterns_list.first
      end
    end 
    
    ancestors.reverse
  end

  # Used for accessing the relationships (e.g for the standard P-Sigma formalism: 
  # Use, Alternative, Requires and Refines)
  # When using the setter method (e.g requires=), we add the relation type to the
  # record that is being constructed
  # def method_missing(method, *args, &block)
  #   # We first check if the method name corresponds to one of the registered relationships
  #   if pattern_system.nil? || pattern_system.registered_relations.nil?
  #     return super
  #   end
  #   if pattern_system.registered_relations.any?{|relation| relation[:type]==method}
  #     # We then return all the patterns which correspond to the 'method' relationship type

  #     relations.select{|rel| rel.name == method.to_s}
  #   else
  #     registered_relation = pattern_system.registered_relations.select{|relation|relation[:type].to_s.concat('=').to_sym == method}.first
  #     if registered_relation && args[0].class == Array
  #       # In that case we need to replace all the relationships of type :type
  #       
  #       # We first destroy all existing relations (N.B Not the most efficient, most certainly!)
  #       relations.select{|rel| rel.name.to_s.concat('=').to_sym == method}.each{|rel|  
  #          
  #          # We destroy the reflected relations too!
  #          if registered_relation[:is_reflexive]
  #            Relation.find(:first, :conditions => {:source_pattern_id => rel.target_pattern, :target_pattern_id => self}).destroy
  #          end
  #          
  #          rel.destroy
  #       }
  #       
  #       # Then we assign all the relations from the method call, and we fill the 'type' attribute for each relation
  #       args[0].each{|new_rel| 
  #         relations << Relation.create({:target_pattern => new_rel, :name => method.to_s.gsub( /=/, ""), :source_pattern => self})
  #         # If the relation is reflexive, create another reverse relation
  #         if registered_relation[:is_reflexive]
  #           Relation.create({:target_pattern => self, :name => method.to_s.gsub( /=/, ""), :source_pattern => new_rel})
  #         end
  #       }
  #     else
  #       super
  #     end
  #   end
  # end
  
protected
  def validate
    errors.add_on_empty %w( name  author  )
    # NB The current pattern is not yet saved in the DB, so we need to check if there is ONE other pattern with the same name
    is_valid = true
    existing_pat = ProcessPattern.find_all_by_name(attributes['name']) - Array(self)
    existing_pat.each do |pat| 
      is_valid &= pat.pattern_system.nil? || pat.pattern_system.id != attributes['pattern_system_id']
    end unless existing_pat.blank?
    errors.add(:name, :taken) unless is_valid
  end
end
