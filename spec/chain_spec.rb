require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Backdat::Chain" do
  before(:each) do
    @chain = Backdat::Chain.new
  end

  after(:each) do
    @chain = nil
  end

  it "should be able to add a single link" do
    link = Backdat::Link.new
    @chain.add(link)
    @chain.root.should eql(link)
    @chain.tail.should eql(link)
  end

  it "should be able to add two links" do
    link1 = Backdat::Link.new
    link2 = Backdat::Link.new
    @chain.add(link1)
    @chain.add(link2)
    @chain.root.should eql(link1)
    @chain.tail.should eql(link2)
  end

  it "should be able to add an arbitrary number of links" do
    link1 = Backdat::Link.new
    link2 = Backdat::Link.new
    link3 = Backdat::Link.new
    @chain.add(link1)
    @chain.add(link2)
    @chain.add(link3)
    @chain.root.should eql(link1)
    @chain.tail.should eql(link3)
  end

  it "should be able to remove a link" do
    link1 = Backdat::Link.new
    link2 = Backdat::Link.new
    link3 = Backdat::Link.new
    @chain.add(link1)
    @chain.add(link2)
    @chain.add(link3)
    @chain.remove(link3)
    @chain.root.should eql(link1)
    @chain.tail.should eql(link2)
  end
end
