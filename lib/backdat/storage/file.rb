# The backdat File storage object.
class Backdat::Storage::File < Backdat::Storage::Base
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
  end

  def file_list
  end
end
