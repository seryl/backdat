require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Backdat::Link" do
  before(:each) do
    @link = Backdat::Link.new
  end

  after(:each) do
    @link = nil
  end

  it "should have a default name of `Link`" do
    @link.name.should eql("Link")
  end

  it "should support fall-thru parameter checking at initialization" do
    @link = Backdat::Link.new(:bleh => "awesome")
    @link.link_config(:bleh).should eql("awesome")
  end

  it "should support fall-thru parameter checking" do
    @link.link_config(:blehk).should eql(nil)
    Backdat::Config[:link_blehk] = "cool"
    @link.link_config(:blehk).should eql("cool")
    Backdat::Config.configuration.delete(:link_blehk)
  end

  it "should default to the `:files` format" do
    @link.format.should eql(:files)
  end

  it "should have nil as a default next" do
    @link.next.should eql(nil)
  end

  it "should have nil as a default before" do
    @link.before.should eql(nil)
  end
end
