require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fileutils'
require 'fakefs/spec_helpers'

describe "Backdat::Storage::Rsync" do
  include FakeFS::SpecHelpers

  before(:each) do
    @storage = Backdat::Storage::Rsync.new
  end

  after(:each) do
    @storage = nil
  end

  it "should have the proper name" do
    @storage.name.should eql("Rsync")
  end

  it "should have a default path of nil" do
    @storage.path.should eql(nil)
  end

  it "should be able to set a default path" do
    @storage = Backdat::Storage::Rsync.new(:path => 'test_path')
    @storage.path.should eql('test_path')
  end

  it "should be able to set a default path from config" do
    Backdat::Config[:rsync_path] = "test_path"
    Backdat::Storage::Rsync.new.path.should eql('test_path')
    Backdat::Config.configuration.delete(:rsync_path)
  end

  it "should have a delete disabled by default" do
    @storage = Backdat::Storage::Rsync.new
    @storage.delete.should eql(false)
  end

  it "should be able to set the delete flag" do
    @storage = Backdat::Storage::Rsync.new(:delete => true)
    @storage.delete.should eql(true)
  end

  it "should be able to set the default delete flag from config" do
    Backdat::Config[:rsync_delete] = true
    @storage = Backdat::Storage::Rsync.new
    @storage.delete.should eql(true)
  end

  it "should have a default transfer method of `:rsync`" do
    @storage = Backdat::Storage::Rsync.new
    @storage.method.should eql(:rsync)
  end

  it "should have a default transfer method of `:rsync`" do
    @storage = Backdat::Storage::Rsync.new
    @storage.method.should eql(:rsync)
  end

  it "should be able to get a list of files in a directory" do
    FakeFS do
      FakeFS::FileSystem.clear
      Dir.chdir('/')
      Dir.mkdir('exampledir')
      FileUtils.touch('blehk')
      FileUtils.touch('blehk2')

      @storage = Backdat::Storage::Rsync.new(:path => '/')
      @storage.file_list.should eql(['/exampledir', '/blehk', '/blehk2'])
    end
  end

  it "should be able to get a list of files in a directory" do
    FakeFS do
      FakeFS::FileSystem.clear
      Dir.chdir('/')
      Dir.mkdir('exampledir')
      FileUtils.touch('blehk')
      FileUtils.touch('blehk2')

      @storage = Backdat::Storage::Rsync.new(:path => '/')
      @storage.exclude_item('blehk')
      @storage.file_list.should eql(['/exampledir', '/blehk2'])
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

      @storage = Backdat::Storage::Rsync.new(:path => '/')
      @storage.exclude_item("blehk[\\d]+")
      @storage.file_list.should eql(['/exampledir', '/blehk'])
    end
  end
end
