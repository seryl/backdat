# A target, source, or intermediary in a backup or restore chain.
class Backdat::Link
  attr_reader :params, :data
  attr_accessor :before, :next, :chain

  # @param [ Hash ] params The parameters to initialize the link with.
  # 
  # @option params [ String ] :path The representation of the path to the link.
  def initialize(params={})
    @params = params
    @before = nil
    @next = nil
    @chain = nil
    @data ||= Backdat::Data::Base.new
  end

  # Yields a Backdat::Data enumerator for the next link to consume/backup.
  # 
  # @note The iterator typing is based on the `@format` given.
  # 
  # @yield [ Backdat::Data ] A Backdat::Data enumerator.
  def backup
    unless is_target?
      @before.data.each { |_data| yield _data if block_given? } if @before
    end
  end

  # Yields a Backdat::Data enumerator for the prior link to consume/restore.
  # 
  # @note The iterator handler is based on the `@format` given.
  # 
  # @yield [ Backdat::Data ] A Backdat::Data enumerator.
  def restore
    if is_source?
      @next.data.each { |_data| yield _data if block_given? } if @next
    end
  end

  # The name of the link type.
  # 
  # @return [ String ] The name of the link type.
  def name
    self.class.name.split('::').last
  end

  # The format of the data enumerator.
  # 
  # @return [ Symbol ] The format of the data parameter.
  def format
    @data.format == :base ? :file : @data.format
  end

  # Uses the passed in parameter or defaults to the configuration.
  # 
  # @param [ Symbol ] cfg The parameter to check `params` for.
  def link_config(cfg)
    @params.fetch(cfg) do
      Backdat::Config["#{self.name.downcase}_#{cfg.to_s}".to_sym]
    end
  end

  # Checks whether the current link is a source node.
  # 
  # @return [ Boolean ] Whether or not the current link is a source node.
  def is_source?
    @before.nil?
  end

  # Checks whether the current link is a target node.
  # 
  # @return [ Boolean ] Whether or not the current link is a target node.
  def is_target?
    not is_source? and @next.nil? and @chain.size > 1
  end
end
