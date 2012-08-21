# A target, source, or intermediary in a backup or restore chain.
class Backdat::Link
  attr_reader :params, :format
  attr_accessor :before, :next, :chain

  # @param [ Hash ] params The parameters to initialize the link with.
  # 
  # @option params [ String ] :path The representation of the path to the link.
  def initialize(params={})
    @params = params
    @before = nil
    @next = nil
    @chain = nil
    @format = :file
  end

  # Processes the current link.
  def process
    is_source? ? backup : restore
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

  # The name of the link type.
  # 
  # @return [ String ] The name of the link type.
  def name
    self.class.name.split('::').last
  end

  # Uses the passed in parameter or defaults to the configuration.
  # 
  # @param [ Symbol ] cfg The parameter to check `params` for.
  def link_config(cfg)
    @params.fetch(cfg) do
      Backdat::Config["#{self.name.downcase}_#{cfg.to_s}".to_sym]
    end
  end
end
