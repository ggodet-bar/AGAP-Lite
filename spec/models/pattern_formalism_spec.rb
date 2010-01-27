def have_a_field_descriptor_named(expected)
  simple_matcher("a field descriptor named #{expected}") do |given, matcher|
    matcher.failure_message = "expected to find a field descriptor named #{expected}"
    matcher.negative_failure_message = "did not expect to find a field descriptor named #{expected}"
    given.field_descriptors.any?{|fie| fie.name == expected}
  end
end

describe "A pattern formalism" do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
    @pattern = PatternFormalism.new(@valid_attributes)
  end

  after(:each) do
    @pattern.destroy
  end


  it "should create a new instance given valid attributes" do
    PatternFormalism.create!(@valid_attributes)
  end

  it "should have default unalterable field descriptors such as 'name', 'problem', which should not be allowed to be destroyed" do
    @pattern.should have(2).field_descriptors
    @pattern.should have_a_field_descriptor_named('name')
    @pattern.should have_a_field_descriptor_named('problem')
    lambda {
      @pattern.field_descriptors.each do |fie|
        fie.destroy
      end
    }.should_not change(@pattern, :field_descriptors)
  end
  
  it "should only have fields included either one of the main sections" do
    # TODO Add some fields

    @pattern.field_descriptors.all?{|fie| PatternFormalism::FORMALISM_SECTIONS.include?(fie.section)}.should be_true
  end

  it "should allow saving field descriptors following their order in the field_descriptors array" do
    @pattern.should have(2).field_descriptors
    @pattern.save.should be_true
    @pattern.field_descriptors.build({
      :name => "a field",
      :section => "interface",
      :field_type => "string",
    })
    @pattern.field_descriptors.build({
      :name => "another field",
      :section => "interface",
      :field_type => "text",
    })
    @pattern.save.should be_true

    @pattern.should have(4).field_descriptors
    @pattern.field_descriptors[0].name.should eql("name")
    @pattern.field_descriptors[0].index.should eql(1)
    @pattern.field_descriptors[1].name.should eql("problem")
    @pattern.field_descriptors[1].index.should eql(2)
    @pattern.field_descriptors[2].name.should eql("a field")
    @pattern.field_descriptors[2].index.should eql(3)
    @pattern.field_descriptors[3].name.should eql("another field")
    @pattern.field_descriptors[3].index.should eql(4)
  end
end
