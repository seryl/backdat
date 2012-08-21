require 'set'

# The backdat File storage object.
class Backdat::Storage::File < Backdat::Storage::Base
  attr_reader :excluded

  # Creates a new File storage object.
  # 
  # @param [ Hash ] params The parameters to initialize the File object with.
  # 
  # @option params [ String ] :path The path to the File object.
  # @option params [ String ] :folder The optional folder to use.
  def initialize(params={})
    super
    @path = link_config :path
    @folder = link_config :folder
    @excluded = ['.', '..', '.backdat']
    exclude_item(link_config :exclude)
  end

  # Returns the list of files at the given path.
  # 
  # @return [ Array ] The list of files at the given path.
  def file_list
    Dir.entries(@path).select do |f|
      @excluded.each do |_exclude|
        break false if f.match(/^#{_exclude}$/)
      end
    end
  end

  # Add an item or list of items to the excluded list.
  # 
  # @note Takes any string or splat to match.
  # 
  # @param [ Array ] The list of string to match against.
  def exclude_item(items)
    exclude = @excluded.to_set
    Array(items).each { |i| exclude << i }
    @excluded = exclude.to_a
  end
end
