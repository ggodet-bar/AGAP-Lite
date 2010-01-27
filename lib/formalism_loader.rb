module FormalismLoader

  # We are given a yaml object that describes a set
  # of pattern system formalisms.
  # NB We are NOT using ruby serialization at the
  # moment
  def FormalismLoader::load_from_yaml(obj)
    obj.each do |system_desc|
      # We first need to parse the pattern formalisms
      patterns = system_desc[:pattern_formalisms].collect do |pattern_desc|
        # We first need to parse the field descriptors
        fields = pattern_desc[:field_descriptors]
        # We replace the arrays by actual ruby objects
        pattern_desc[:field_descriptors] = []

        # Once all the arrays are replaced, we may create
        # the pattern formalism
        pattern = PatternFormalism.create pattern_desc
        pattern.field_descriptors.create fields
        pattern
      end
      # Next we parse the relation descriptors
      relations_desc = system_desc[:relation_descriptors] || []
      relations = relations_desc.collect{|rel| RelationDescriptor.new(rel)}
      system_desc[:relation_descriptors] = []
      system_desc[:pattern_formalisms] = []

      # And finally we create the system formalism
      a_system = SystemFormalism.new system_desc
      a_system.pattern_formalisms << patterns
      a_system.relation_descriptors << relations
      if a_system.save
        puts "Successfully created the system formalism: #{a_system.name}"
      else
        puts "Failed to create a system formalism: #{a_system.name}"
        a_system.errors.each_full{|err| puts err}
      end
    end
  end
end
