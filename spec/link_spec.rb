require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Backdat::Link" do
  before(:each) do
    @link = Backdat::Link.new
  end

  after(:each) do
    @link = nil
  end
end
