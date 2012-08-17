require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Backdat::Storage::S3" do
  before(:each) do
    @storage = Backdat::Storage::S3.new
  end

  after(:each) do
    @storage = nil
  end

  it "should have the proper name" do
    @storage.name.should eql("S3")
  end
end
