require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Backdat::Filter" do
  it "should have a list of all of the current plugins" do
    plugins = ["Base"]
    Backdat::Filter.plugins.should eql(plugins)
  end
end
