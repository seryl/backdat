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
  end
end

Dir.glob("#{File.join(File.dirname(__FILE__), "filter")}/*").each do |s|
  require "backdat/filter/#{File.basename(s)}"
end
