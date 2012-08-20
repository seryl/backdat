# A target, source, or intermediary in a backup or restore chain.
class Backdat::Link

  # The parameters passed to the link object.
  attr_reader :params

  # The prior link object in the chain.
  attr_accessor :before

  # The next link object in the chain.
  attr_accessor :next

  # The format the link object will export with.
  attr_reader :format

  # @param [ Hash ] params The parameters to initialize the link with.
  # 
  # @option params [ String ] :path The representation of the path to the link.
  def initialize(params={})
    @params = params
    @before = nil
    @next = nil
    @format = :file
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
