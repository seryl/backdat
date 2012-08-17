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
    
    # Creates a new storage object.
    def initialize
    end

    # The name of the storage class.
    # 
    # @return [ String ] The name of the storage class.
    def name
      self.class.name.split('::').last
    end

    # Backup data from the chain.
    # 
    # @param [ Backdat::Chain ] chain The chain to backup from.
    # 
    # @return [ true,false ] Whether or not the operation succeeded.
    def backup(chain=nil)
      true
    end

    # Restores data from the chain.
    # 
    # @param [ Backdat::Chain ] chain The chain to restore onto.
    # 
    # @return [ true,false ] Whether or not the operation succeeded.
    def restore(chain=nil)
      true
    end

  end
end

Dir.glob("#{File.join(File.dirname(__FILE__), "storage")}/*").each do |s|
  require "backdat/storage/#{File.basename(s)}"
end
