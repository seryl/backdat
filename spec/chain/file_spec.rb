require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fileutils'
require 'fakefs/safe'

describe "Backdat::Chain (Basic File Operations)" do

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

  it "should be able to copy a file list from one place to another" do
    source = Backdat::Storage::Local.new(:path => '/source')
    target = Backdat::Storage::Local.new(:path => '/target')
    @chain.add(source)
    @chain.add(target)
  end

  it "should be able to move a file list from one place into another" do
    source = Backdat::Storage::Local.new(:path => '/source', :method => :mv)
    target = Backdat::Storage::Local.new(:path => '/target', :method => :mv)
    @chain.add(source)
    @chain.add(target)
  end
end
