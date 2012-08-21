require 'backdat/storage/local'

# The backdat Rsync storage object.
class Backdat::Storage::Rsync < Backdat::Storage::Local
  attr_reader :excluded, :delete

  # Creates a new Rsync storage object.
  # 
  # @param [ Hash ] params The parameters to initialize the Rsync object with.
  # 
  # @option params [ String ] :path The path to the Rsync object.
  # @option params [ String ] :folder The optional folder to use.
  # @option params [ String ] :method The method for target transfers.
  # @option params [ String ] :delete Whether or not to delete mixmatches.
  def initialize(params={})
    super
    @method = :rsync
    @delete = link_config(:delete).to_s == "true"
  end
end
