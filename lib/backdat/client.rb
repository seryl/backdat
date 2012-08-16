# The backdat client application.
class Backdat::Client

  attr_reader :commands

  COMMAND_ALIASES = [
    :backup   => ['backup', 'back', 'b'],
    :restore  => ['restore', 'rest', 'r']
  ]

  def initialize(commands=[])
    @commands = commands
  end

  def run
    p "awesome"
    p @commands
    # aliases
  end

  private

  def aliases(cmd)
    COMMAND_ALIASES.each { |k,v| return k if v.include?(cmd) }
    nil
  end
end
