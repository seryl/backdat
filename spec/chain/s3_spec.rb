require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fileutils'
require 'fakefs/safe'

describe "Backdat::Chain (Basic S3 Operations)", :live => true do

  before(:each) do
    @chain = Backdat::Chain.new
    FakeFS.activate!
    FakeFS::FileSystem.clear

    Dir.chdir('/')
    Dir.mkdir('source')
    Dir.mkdir('target')
    Dir.chdir('source')
    File.open("somefile.example", 'w') { |f| f.write "blehk" }
    Dir.chdir('/')
  end

  after(:each) do
    @chain = nil
    FakeFS.deactivate!
  end

  it "should be able to backup a file list to s3"

  it "should be able to restore a file list from s3"
end
