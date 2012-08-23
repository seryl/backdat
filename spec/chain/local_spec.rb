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

  it "should be able to backup (copy) a file list" do
    source = Backdat::Storage::Local.new(:path => '/source')
    target = Backdat::Storage::Local.new(:path => '/target')
    @chain.add(source)
    @chain.add(target)
    @chain.backup
    Dir.entries('/source').should eql(['.', '..', 'somefile.example'])
    Dir.entries('/target').should eql(['.', '..', 'somefile.example'])
  end

  it "should be able to restore (copy) a file list" do
    FileUtils.mv('/source', '/temp')
    FileUtils.mv('/target', '/source')
    FileUtils.mv('/temp', '/target')

    source = Backdat::Storage::Local.new(:path => '/source')
    target = Backdat::Storage::Local.new(:path => '/target')
    @chain.add(source)
    @chain.add(target)
    @chain.restore
    Dir.entries('/source').should eql(['.', '..', 'somefile.example'])
  end

  it "should be able to backup (move) a file list" do
    source = Backdat::Storage::Local.new(:path => '/source', :method => :mv)
    target = Backdat::Storage::Local.new(:path => '/target')
    @chain.add(source)
    @chain.add(target)
    @chain.backup
    Dir.entries('/target').should eql(['.', '..', 'somefile.example'])
  end

  it "should be able to restore (move) a file list" do
    FileUtils.mv('/source', '/temp')
    FileUtils.mv('/target', '/source')
    FileUtils.mv('/temp', '/target')

    source = Backdat::Storage::Local.new(:path => '/source', :method => :mv)
    target = Backdat::Storage::Local.new(:path => '/target')
    @chain.add(source)
    @chain.add(target)
    @chain.restore
    Dir.entries('/source').should eql(['.', '..', 'somefile.example'])
    Dir.entries('/target').should eql(['.', '..', 'somefile.example'])
  end

  it "should be able to restore (move-destructively) a file list" do
    FileUtils.mv('/source', '/temp')
    FileUtils.mv('/target', '/source')
    FileUtils.mv('/temp', '/target')

    source = Backdat::Storage::Local.new(:path => '/source', :method => :mv)
    target = Backdat::Storage::Local.new(:path => '/target', :method => :mv)
    @chain.add(source)
    @chain.add(target)
    @chain.restore
    Dir.entries('/source').should eql(['.', '..', 'somefile.example'])
  end
end
