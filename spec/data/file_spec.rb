require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Backdat::Data::File" do
  before(:each) do
    @data = Backdat::Data.new
  end

  after(:each) do
    @data = nil
  end

  it "should have a default path of []" do
    @data.instance_variable_get(:@path).should eql([])
  end

  it "should have a default format of `:file`" do
    @data.instance_variable_get(:@format).should eql(:file)
  end

  it "should yield a single filename per iteration" do
    @data = Backdat::Data.new(["/test", "/path/to/example"])
    @data.
  end
end
