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

  it "should be able to check whether it is a source" do
    @link.is_source?.should eql(true)
    @link.is_target?.should eql(false)
  end

  it "should be able to check whether it is a target" do
    chain = Backdat::Chain.new
    source = Backdat::Link.new
    source.next = @link
    @link.before = source
    chain.add(source)
    chain.add(@link)
    source.is_source?.should eql(true)
    @link.is_target?.should eql(true)
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

  it "should default to the `:file` format" do
    @link.format.should eql(:file)
  end

  it "should have nil as a default next" do
    @link.next.should eql(nil)
  end

  it "should have nil as a default before" do
    @link.before.should eql(nil)
  end

  it "should have `Backdat::Data::Base` as the default data enumerator" do
    @link.instance_variable_get(:@data).format.should \
        eql(Backdat::Data::Base.new.format)
  end

  it "should be able to safely run backup with a nil `@next`" do
    lambda { @link.backup }.should_not raise_error
  end

  it "should be able to safely run restore with a nil `@before`" do
    lambda { @link.restore }.should_not raise_error
  end
end
