require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Backdat::VERSION" do
  it "should have a version that is not nil" do
    Backdat::VERSION.nil?.should eql(false)
  end

  it "should have a version that is not empty" do
    Backdat::VERSION.empty?.should eql(false)
  end
end
