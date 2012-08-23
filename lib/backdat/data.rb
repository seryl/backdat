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
    # @param [ Array ] items The list of items for the enumerator.
    def initialize(items=[])
      @items = items
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
      @items.each { |_item| yield _item }
    end
  end
end

Dir.glob("#{File.join(File.dirname(__FILE__), "data")}/*").each do |s|
  require "backdat/data/#{File.basename(s)}"
end
