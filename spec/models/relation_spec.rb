describe Relation do

  before(:each) do
    RelationDescriptor.all.map(&:destroy)
    Relation.all.map(&:destroy)
    @reflexive_descriptor_attributes = {
      :name => "Reflexive relation",
      :is_reflexive => true,
      :is_alterable => true,
      :system_formalism_id => 1
    }
    @non_reflexive_descriptor_attributes = {
      :name => "Non reflexive relation",
      :is_reflexive => false,
      :is_alterable => true,
      :system_formalism_id => 1
    }

    @relation_attributes = {
      :source_pattern_id => 1,
      :target_pattern_id => 2
    }
  end

  it "should create a single relation if the relation descriptor designates a non-reflexive relation" do
    descriptor = RelationDescriptor.create(@non_reflexive_descriptor_attributes)
    new_relation = Relation.create(@relation_attributes.merge({:relation_descriptor_id => descriptor.id}))
    Relation.count.should == 1
  end

  it "should destroy a single relation if the relation descriptor designates a non-reflexive relation" do
    descriptor = RelationDescriptor.create(@non_reflexive_descriptor_attributes)
    new_relation = Relation.create(@relation_attributes.merge({:relation_descriptor_id => descriptor.id}))
    
    new_relation.destroy

    Relation.count.should == 0
  end

  it "should create 2 relations when the relation descriptor designates a reflexive relation" do
    descriptor = RelationDescriptor.create(@reflexive_descriptor_attributes)
    new_relation = Relation.create(@relation_attributes.merge({:relation_descriptor_id => descriptor.id}))
    Relation.count.should == 2
  end

  it "should create 2 relations with mirrored source and target pattern ids when the relation descriptor designates a reflexive relation" do
    descriptor = RelationDescriptor.create(@reflexive_descriptor_attributes)
    new_relation = Relation.create(@relation_attributes.merge({:relation_descriptor_id => descriptor.id}))

    Relation.where(:source_pattern_id => 1).where(:target_pattern_id => 2).should be_present
    Relation.where(:source_pattern_id => 2).where(:target_pattern_id => 1).should be_present
  end

  it "should delete 2 relations with mirrored source and target pattern ids when the relation descriptor designates a reflexive relation" do
    descriptor = RelationDescriptor.create(@reflexive_descriptor_attributes)
    new_relation = Relation.create(@relation_attributes.merge({:relation_descriptor_id => descriptor.id}))

    new_relation.destroy

    Relation.count.should == 0
  end
end
