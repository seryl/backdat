require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Backdat::Data::Base" do
  before(:each) do
    @data = Backdat::Data::Base.new
  end

  after(:each) do
    @data = nil
  end

  it "should have an empty list of default items" do
    @data.instance_variable_get(:@items).should eql([])
  end

  it "should have a format type of `:base`" do
    @data.format.should eql(:base)
  end

  it "should yield the next item for each request" do
    path = ["awesome", "cool", "blehk"]
    @data = Backdat::Data::Base.new(path)
    @data.each_with_index { |item, index| path[index].should eql(item) }
  end
end
