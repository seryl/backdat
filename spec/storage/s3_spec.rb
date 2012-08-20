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

  it "should have a default path of nil" do
    @storage.path.should eql(nil)
  end

  it "should be able to set a default path" do
    @storage = Backdat::Storage::S3.new(:path => 'test_path')
    @storage.path.should eql('test_path')
  end

  it "should be able to set a default path from config" do
    Backdat::Config[:s3_path] = "test_path"
    Backdat::Storage::S3.new.path.should eql('test_path')
    Backdat::Config.configuration.delete(:s3_path)
  end

  it "should be able to set a default bucket" do
    @storage = Backdat::Storage::S3.new(:bucket => 'test_bucket')
    @storage.bucket.should eql('test_bucket')
  end

  it "should be able to set a default bucket from config" do
    Backdat::Config[:s3_bucket] = "test_bucket"
    Backdat::Storage::S3.new.bucket.should eql('test_bucket')
    Backdat::Config.configuration.delete(:s3_bucket)
  end

  it "should be able to set a default access key" do
    @storage = Backdat::Storage::S3.new(:access_key => 'test_key')
    @storage.access_key.should eql('test_key')
  end

  it "should be able to set a default access key from config" do
    Backdat::Config[:s3_access_key] = "test_key"
    Backdat::Storage::S3.new.access_key.should eql('test_key')
    Backdat::Config.configuration.delete(:s3_access_key)
  end

  it "should be able to set a default access secret" do
    @storage = Backdat::Storage::S3.new(:access_secret => 'test_secret')
    @storage.access_secret.should eql('test_secret')
  end

  it "should be able to set a default access secret from config" do
    Backdat::Config[:s3_access_secret] = "test_secret"
    Backdat::Storage::S3.new.access_secret.should eql('test_secret')
    Backdat::Config.configuration.delete(:s3_access_secret)
  end
end
