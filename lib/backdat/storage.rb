# The bakdat storage module.
module Backdat::Storage
  class << self
    # Returns the list of available storage plugins.
    # 
    # @return [ List ] The list of available storage plugins.
    def plugins
      self.constants.map { |k| k.to_s }
    end
  end

  # The base backdat storage plugin class.
  class Base < Backdat::Link
    
    # The path to the storage object.
    attr_accessor :path
  end
end

Dir.glob("#{File.join(File.dirname(__FILE__), "storage")}/*").each do |s|
  require "backdat/storage/#{File.basename(s)}"
end
