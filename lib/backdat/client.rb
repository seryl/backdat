# The backdat client application.
class Backdat::Client
  attr_reader :original_dir, :commands, :cmd

  # The command aliases for 
  COMMAND_ALIASES = {
    :backup   => ['backup', 'back', 'b'],
    :restore  => ['restore', 'rest', 'r']
  }

  # Initializes the backdat client.
  # 
  # @param [ Array ] commands The unparsed mixlib-cli parameters.
  # @param [ String ] original_dir The path to the calling directory.
  def initialize(commands=[], original_dir)
    @commands = commands
    @original_dir = original_dir
    cmd_list = @commands.dup

    @cmd = aliases(cmd_list.first).nil? ? nil : aliases(cmd_list.pop)
    @first  = cmd_list.pop || @original_dir
    @second = cmd_list.pop
  end

  # Runs the command line client.
  def run
    warn_about_aliases if @cmd.to_s == @first
    generate_job
  end

  # Creates a new job from the parameters.
  def generate_job
    if Backdat::Config[:json].empty?
      Backdat::Config[:json] = File.absolute_path("#{@first}/.backdat")
    end
    job_config = parse_dotfile
    run_job
  end

  # Parses the backdat dotfile and creates it if it's missing.
  def parse_dotfile
    if File.exists? Backdat::Config[:json]
      raise Backdat::Exceptions::InvalidDotfile,
            "The .backdat file #{Backdat::Config[:json]} is invalid."
    else
      create_backdat_file
    end
  end

  # Creates a new backdat dotfile based on the parameters given.
  def create_backdat_file
    puts "Creating backdat file"
  end

  # Runs the job for the given parameters.
  def run_job
  end

  # Prints an alias warning and exits if the command intent isn't clear.
  def warn_about_aliases
    Backdat::Log.warn "*****************************************"
    Backdat::Log.warn "The #{@cmd} command is aliased to #{@first}."
    Backdat::Log.warn "Please be explicit with SOURCES and TARGETS."
    Backdat::Log.warn "   Ex: #{$0} ./source /path/to/target"
    Backdat::Log.warn "*****************************************"
    exit 0
  end

  # Gets the symbol mapping to be used with generate_job for a given command.
  # 
  # @param [ String ] cmd The command to lookup the alias for.
  # 
  # @return [ Symbol ] The symbol to send to see whether there is an alias.
  def aliases(cmd)
    COMMAND_ALIASES.each { |k,v| return k if v.include?(cmd) }
    nil
  end
end
