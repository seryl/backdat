require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Backdat::Storage::File" do
  before(:each) do
    @storage = Backdat::Storage::File.new
  end

  after(:each) do
    @storage = nil
  end

  it "should have the proper name" do
    @storage.name.should eql("File")
  end

  it "should have a default path of nil" do
    @storage.path.should eql(nil)
  end

  it "should be able to set a default path" do
    @storage = Backdat::Storage::File.new(:path => 'test_path')
    @storage.path.should eql('test_path')
  end

  it "should be able to set a default path from config" do
    Backdat::Config[:file_path] = "test_path"
    Backdat::Storage::File.new.path.should eql('test_path')
    Backdat::Config.configuration.delete(:file_path)
  end
end
