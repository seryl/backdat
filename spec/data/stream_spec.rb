require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Backdat::Data::Stream" do
  before(:each) do
    @data = Backdat::Data::Stream.new
  end

  after(:each) do
    @data = nil
  end

  it "should have an empty path list" do
    @data.path.should eql([])
  end

  it "should have a format type of `:stream`" do
    @data.format.should eql(:stream)
  end

  it "should yield the next item for each request"
end
