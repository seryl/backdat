# The backdat S3 storage object.
class Backdat::Storage::S3 < Backdat::Storage::Base
  attr_reader :access_key, :access_secret, :bucket

  # Creates a new S3 storage object.
  # 
  # @param [ Hash ] params The parameters to initialize the S3 object with.
  # 
  # @option params [ String ] :path The path to the S3 object.
  # @option params [ String ] :bucket The bucket for the S3 object.
  # @option params [ String ] :access_key The AWS S3 access key.
  # @option params [ String ] :access_secret The AWS S3 access secret.
  def initialize(params={})
    super
    @path = link_config :path
    @bucket = link_config :bucket
    @access_key = link_config :access_key
    @access_secret = link_config :access_secret
  end

  # Yields a Backdat::Data enumerator for the next link to consume/backup.
  # 
  # @note The iterator typing is based on the `@format` given.
  # 
  # @yield [ Backdat::Data ] A Backdat::Data enumerator.
  def backup
  end

  # Yields a Backdat::Data enumerator for the prior link to consume/restore.
  # 
  # @note The iterator handler is based on the `@format` given.
  # 
  # @yield [ Backdat::Data ] A Backdat::Data enumerator.
  def restore
  end
end
