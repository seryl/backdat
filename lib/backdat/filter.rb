# The bakdat filter module.
module Backdat::Filter
  class << self
    # Returns the list of available filter plugins.
    # 
    # @return [ List ] The list of available filter plugins.
    def plugins
      self.constants.map { |k| k.to_s }
    end
  end

  # The base backdat filter plugin class.
  class Base < Backdat::Link
    
    # Creates a new filter object.
    def initialize(chain=nil)
      @chain = chain
    end

    # The name of the filter class.
    # 
    # @return [ String ] The name of the filter class.
    def name
      self.class.name.split('::').last
    end

    # Filters a 
    # 
    # @param [ Backdat::Link ] target The restore target.
    def restore(target=nil, source=nil)
      true
    end

  end
end

Dir.glob("#{File.join(File.dirname(__FILE__), "filter")}/*").each do |s|
  require "backdat/filter/#{File.basename(s)}"
end
