require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Backdat::Data::File" do
  before(:each) do
    @data = Backdat::Data::File.new
  end

  after(:each) do
    @data = nil
  end

  it "should have an empty path list" do
    @data.path.should eql([])
  end

  it "should have a format type of `:file`" do
    @data.format.should eql(:file)
  end

  it "should yield the next item for each request" do
    path = ["awesome", "cool", "blehk"]
    @data = Backdat::Data::File.new(path)
    @data.each_with_index { |item, index| path[index].should eql(item) }
  end
end
