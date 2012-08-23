require 'set'
require 'fileutils'

# The backdat Local storage object.
class Backdat::Storage::Local < Backdat::Storage::Base
  attr_reader :excluded

  # Creates a new Local storage object.
  # 
  # @param [ Hash ] params The parameters to initialize the Local object with.
  # 
  # @option params [ String ] :path The path to the Local object.
  # @option params [ String ] :folder The optional (remote) folder to use.
  # @option params [ String ] :method The method for target transfers.
  def initialize(params={})
    super
    @path = link_config :path
    @excluded = ['.', '..', '.backdat']
    exclude_item(link_config :exclude)
    @method = link_config(:method) || :cp
    @data = Backdat::Data::File.new(file_list)
  end

  # Yields a Backdat::Data enumerator for the next link to consume/backup.
  # 
  # @note The iterator typing is based on the `@format` given.
  # 
  # @yield [ Backdat::Data ] A Backdat::Data enumerator.
  def backup
    
  end

  # Yields a Backdat::Data enumerator for the next link to consume/restore.
  # 
  # @note The iterator typing is based on the `@format` given.
  # 
  # @yield [ Backdat::Data ] A Backdat::Data enumerator.
  def restore
  end

  # Returns the list of files at the given path.
  # 
  # @return [ Array ] The list of files at the given path.
  def file_list
    Array(@path).inject(Set.new) do |list, _path|
      next list unless File.exists?(_path)
      if File.directory?(_path)
        list = list | sanitized_directory(_path)
      else
        list << _path if keep_file?(_path)
      end
      list
    end.to_a
  end

  # Add an item or list of items to the excluded list.
  # 
  # @note Takes any string or splat to match.
  # 
  # @param [ Array ] items The list of string to match against.
  def exclude_item(items)
    exclude = @excluded.to_set
    Array(items).each { |_item| exclude << _item }
    @excluded = exclude.to_a
  end

  # The symbolized version of the transfer method.
  # 
  # @return [ Symbol ] The symbolized version of the transfer method.
  def method
    @method.to_sym
  end

  private

  # Checks whether or not the file will be excluded.
  # 
  # @return [ Boolean ] Whether or not to keep a given file.
  def keep_file?(path)
    @excluded.each { |_exclude| return false if path.match(/^#{_exclude}$/) }
    return true
  end

  # The list of files that are not to be excluded in the given path list.
  # 
  # @return [ Array ] The list of files that are not excluded.
  def sanitized_directory(path)
    sane_files = Dir.entries(path).select { |_file| keep_file?(_file) }
    sane_files.map { |_file| File.expand_path(File.join(path, _file)) }
  end
end
