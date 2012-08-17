require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Backdat::Chain" do
  before(:each) do
    @chain = Backdat::Chain.new
  end

  after(:each) do
    @chain = nil
  end
end
