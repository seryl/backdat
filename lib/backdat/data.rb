# The data module grouping for all of the data enumerators.
module Backdat::Data
  class << self
    # Returns the list of available data plugins.
    # 
    # @return [ List ] The list of available data plugins.
    def plugins
      self.constants.map { |k| k.to_s }
    end
  end

  # A data enumerator for the backdat formats.
  class Base
    include Enumerable

    # Creates a new data enumerator.
    # 
    # @param [ Array ] path The list of path items for the enumerator.
    def initialize(path=[])
      @path = path
    end

    # The name of the data type.
    # 
    # @return [ String ] The name of the data type.
    def format
      self.class.name.split('::').last.downcase.to_sym
    end

    # Yields either the next file or stream based on the format.
    # 
    # @yield [ Object ] The next file or chunk.
    def each
      @path.each { |_path| yield _path }
    end
  end
end

Dir.glob("#{File.join(File.dirname(__FILE__), "data")}/*").each do |s|
  require "backdat/data/#{File.basename(s)}"
end
