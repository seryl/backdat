require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fileutils'
require 'fakefs/spec_helpers'

describe "Backdat::Storage::File" do
  include FakeFS::SpecHelpers

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

  it "should be able to get a list of files in a directory" do
    FakeFS do
      FakeFS::FileSystem.clear
      Dir.chdir('/')
      Dir.mkdir('exampledir')
      FileUtils.touch('blehk')
      FileUtils.touch('blehk2')

      @storage = Backdat::Storage::File.new(:path => '/')
      @storage.file_list.should eql(['exampledir', 'blehk', 'blehk2'])
    end
  end

  it "should be able to get a list of files in a directory" do
    FakeFS do
      FakeFS::FileSystem.clear
      Dir.chdir('/')
      Dir.mkdir('exampledir')
      FileUtils.touch('blehk')
      FileUtils.touch('blehk2')

      @storage = Backdat::Storage::File.new(:path => '/')
      @storage.exclude_item('blehk')
      @storage.file_list.should eql(['exampledir', 'blehk2'])
    end
  end

  it "should be able to get a list of files in a directory" do
    FakeFS do
      FakeFS::FileSystem.clear
      Dir.chdir('/')
      Dir.mkdir('exampledir')
      FileUtils.touch('blehk')
      FileUtils.touch('blehk2')
      FileUtils.touch('blehk3')
      FileUtils.touch('blehk4')

      @storage = Backdat::Storage::File.new(:path => '/')
      @storage.exclude_item("blehk[\\d]+")
      @storage.file_list.should eql(['exampledir', 'blehk'])
    end
  end
end
