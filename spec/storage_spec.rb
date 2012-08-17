require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Backdat::Storage" do
  it "should be able to list the currently available plugins" do
    plugins = ["Base", "S3"]
    Backdat::Storage.plugins.should eql(plugins)
  end
end
