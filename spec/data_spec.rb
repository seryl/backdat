require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Backdat::Data" do
  it "should have a list of all of the current plugins" do
    plugins = ["Base", "File", "Stream"]
    Backdat::Data.plugins.should eql(plugins)
  end
end
