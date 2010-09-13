require File.join File.dirname(__FILE__), '../../lib/grapher'

describe Grapher do

  context "Invalid initial conditions" do
    it "should raise an exception if the argument is not an array" do
      lambda {
        Grapher.identify_complete_subgraphs(:fake)
      }.should raise_exception(ArgumentError)
    end

    it "should raise an exception if any element in the set is not an array" do
      lambda {
        Grapher.identify_complete_subgraphs([:fake])
      }.should raise_exception(ArgumentError)
    end

    it "should raise an exception if any element in the set is not a pair" do
      lambda {
        Grapher.identify_complete_subgraphs([[:fake_1, :fake_2, :fake_3]])
      }.should raise_exception(ArgumentError)
    end
  end

  context "Valid initial conditions" do

    it "should return an empty set for an empty edges set" do
      Grapher.identify_complete_subgraphs([]).should == []
    end

    it "should return an array with an array of two elements for an edge set with a single edge" do
      Grapher.identify_complete_subgraphs([['a','b']]).should == [[['a','b']]]
    end
  end

  context "Graph partition" do

    it "should return two arrays for two unconnected pairs" do
      Grapher.identify_complete_subgraphs([['a', 'b'], ['c', 'd']]).should == [[['a', 'b']], [['c', 'd']]]
    end

    it "should return a 3 element array for two connected pairs" do
      Grapher.identify_complete_subgraphs([['a', 'b'], ['a', 'd']]).should == [[['a', 'b'], ['a', 'd']]]
    end

    it "should return three arrays for three unconnected pairs" do
      Grapher.identify_complete_subgraphs([['a', 'b'], ['c', 'd'], ['e', 'f']]).should == [[['a', 'b']], [['c', 'd']], [['e', 'f']]]
    end

    it "should return 2 arrays for three partiallay connected pairs" do
      Grapher.identify_complete_subgraphs([['a', 'b'], ['a', 'd'], ['e', 'f']]).should == [[['a', 'b'], ['a', 'd']], [['e', 'f']]]
    end

    it "should return 1 array for three connected pairs (1 chain element)" do
      Grapher.identify_complete_subgraphs([['a', 'b'], ['a', 'd'], ['d', 'f']]).should == [[['a', 'b'], ['a', 'd'], ['d', 'f']]]
    end

    it "should return 1 array for three connected pairs (2 chain elements)" do
      Grapher.identify_complete_subgraphs([['a', 'b'], ['b', 'd'], ['d', 'f']]).should == [[['a', 'b'], ['b', 'd'], ['d', 'f']]]
    end

    it "should return 2 arrays for 4 partially connected pairs" do
      Grapher.identify_complete_subgraphs([['a', 'b'], ['b', 'd'], ['c', 'f'], ['f', 'g']]).should == [[['a', 'b'], ['b', 'd']], [['c', 'f'], ['f', 'g']]]
    end
  end

  context "Oriented graph partition" do
    it "should return 2 arrays for 2 pairs that share a common 'target'" do
      Grapher.identify_complete_subgraphs([['a', 'b'], ['c', 'b']]).should == [[['a', 'b']], [['c', 'b']]]
    end
  end

  context "Tree creation - 1 level" do
    it "should return a tree with a root and a leaf for a 1-element array" do
      Grapher.treeify_complete_graph([['a', 'b']]).should == {:node => 'a', :children => ['b']}
    end

    it "should return a tree with a root and two leafs for a 2-element array with a common source element" do
      Grapher.treeify_complete_graph([['a', 'b'], ['a', 'c']]).should == {:node => 'a', :children => ['b', 'c']}
    end

    it "should return a tree with a root and three leafs for a 3-element array with a common source element" do
      Grapher.treeify_complete_graph([['a', 'b'], ['a', 'c'], ['a', 'd']]).should == {:node => 'a', :children => ['b', 'c', 'd']}
    end
  end

  context "Tree creation - 2 levels" do
    it "should return a tree with a root for a 3-element array with 2 common source elements" do
      Grapher.treeify_complete_graph([['a', 'b'], ['a', 'c'], ['b', 'd']]).should == {:node => 'a', :children => [{:node => 'b', :children => ['d']}, 'c']}
    end

    it "should return a tree with a root for a 4-element array with 2 common source elements" do
      Grapher.treeify_complete_graph([['a', 'b'], ['a', 'c'], ['b', 'd'], ['b', 'e']]).should == {:node => 'a', :children => [{:node => 'b', :children => ['d', 'e']}, 'c']}
    end

    it "should return a tree with a root for a 4-element array with 3 common source elements" do
      Grapher.treeify_complete_graph([['a', 'b'], ['a', 'c'], ['b', 'd'], ['c', 'e']]).should == {:node => 'a', :children => [{:node => 'b', :children => ['d']}, {:node => 'c', :children => ['e']}]}
    end

    it "should return a tree with a root for a 6-element array with 3 common source elements" do
      Grapher.treeify_complete_graph([['a', 'b'], ['a', 'c'], ['b', 'd'], ['c', 'e'], ['b', 'f'], ['c', 'g']]).should == {:node => 'a', :children => [{:node => 'b', :children => ['d', 'f']}, {:node => 'c', :children => ['e', 'g']}]}
    end
  end

  context "Tree creation - 3 levels" do
    it "should return a tree with a root for a 3-element array with 2 common source elements" do
      Grapher.treeify_complete_graph([['a', 'b'], ['b', 'c'], ['c', 'd']]).should == {:node => 'a', :children => [{:node => 'b', :children => [{:node => 'c', :children => ['d']}]}]}
    end

    it "should return a tree with a root for a 4-element array with 3 common source elements" do
      Grapher.treeify_complete_graph([['a', 'b'], ['b', 'c'], ['c', 'd'], ['c', 'e']]).should == {:node => 'a', :children => [{:node => 'b', :children => [{:node => 'c', :children => ['d', 'e']}]}]}
    end

    it "should return a tree with a root for a 5-element array with 3 common source elements" do
      Grapher.treeify_complete_graph([['a', 'b'], ['b', 'c'], ['b', 'f'], ['c', 'd'], ['c', 'e']]).should == {:node => 'a', :children => [{:node => 'b', :children => [{:node => 'c', :children => ['d', 'e']}, 'f']}]}
    end
  end

  context "Tree creation - 4 levels" do
    it "should return a tree with a root for a 4-element array with 3 common source elements" do
      Grapher.treeify_complete_graph([['a', 'b'], ['b', 'c'], ['c', 'd'], ['d', 'e']]).should == {:node => 'a', :children => [{:node => 'b', :children => [{:node => 'c', :children => [{:node => 'd', :children => ['e']}]}]}]}
    end
  end

  context "Unordered edges" do
    it "should be able to create a tree independently of the edges order" do
      Grapher.treeify_complete_graph([['a', 'b'], ['c', 'd'], ['b', 'c']]).should == {:node => 'a', :children => [{:node => 'b', :children => [{:node => 'c', :children => ['d']}]}]}
    end

    it "should be able to create a tree from a reversed array set" do
      Grapher.treeify_complete_graph([['c', 'd'], ['b', 'c'], ['a', 'b']]).should == {:node => 'a', :children => [{:node => 'b', :children => [{:node => 'c', :children => ['d']}]}]}
    end
  end

  context "No redundant vertices" do
    it "should remove from the tree redundant vertices (i.e., a vertex should only appear once in a tree, first come first served)" do
      pending
      Grapher.treeify_complete_graph([['c', 'd'], ['b', 'c'], ['a', 'b'], ['c', 'a']]).should == {:node => 'a', :children => [{:node => 'b', :children => [{:node => 'c', :children => ['d']}]}]}
    end
  end

end
