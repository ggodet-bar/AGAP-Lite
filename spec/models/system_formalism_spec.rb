Spec::Matchers.define :have_a_relation_descriptor_named do |expected|
  match do |actual|
    actual.relation_descriptors.any?{|rel| rel.name == expected}
  end

  failure_message_for_should do
    "expected to find a relation descriptor named #{expected}"
  end

  failure_message_for_should_not do
    "did not expect to find a relation descriptor named #{expected}"
  end

  description do
    "a relation descriptor named #{expected}"
  end
end

describe "A system formalism" do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :author => "value for author",
      :version => "value for version"
    }
    @formalism = SystemFormalism.new
  end

  it "should be invalid without a name" do
    @formalism.should_not be_valid
  end


  it "should have two unalterable relations named 'use' and 'require'" do
    @formalism.should have(2).relation_descriptors
    @formalism.should have_a_relation_descriptor_named('Use')
    @formalism.should have_a_relation_descriptor_named('Require')
    @formalism.relation_descriptors.all?{|rel| !rel.is_alterable}.should be_true
  end

  it "should not allow deleting unalterable relation descriptors" do
    lambda {
      @formalism.relation_descriptors.each do |rel|
        rel.destroy
      end 
    }.should_not change(@formalism, :relation_descriptors)
  end

  it "should not allow adding unalterable relation descriptors" do
      @formalism.relation_descriptors << RelationDescriptor.new({:name => "Unalterable relation", :is_alterable => false, :system_formalism_id => @formalism.id})
      @formalism.save
      @formalism.errors[:base].should include("Invalid number of unalterable relation descriptors")
  end

  it "should allow adding alterable relation descriptors" do
    @formalism.should have(2).relation_descriptors
    #lambda {
      @formalism.relation_descriptors.build(:name => "Alterable relation", :is_alterable => true, :system_formalism_id => @formalism.id)
    #}.should change(@formalism, :relation_descriptors)
    @formalism.should have(3).relation_descriptors
  end

  
  it "should be saved once all its validation requirements are met (name, author, version and preset associations)" do
    @formalism.should be_new_record
    @formalism.relation_descriptors.all?{|rel| rel.new_record?}.should be_true
    # @formalism.fields.all?{|fie| fie.new_record?}.should be_true

    @formalism[:name] = "A fake formalism"
    @formalism[:author] = "A fake author"
    @formalism[:version] = "0.0.0"
    @formalism.save.should be_true

    @formalism.relation_descriptors.any?{|rel| rel.new_record?}.should be_false
    # @formalism.fields.any?{|fie| fie.new_record?}.should be_false
  end


end
