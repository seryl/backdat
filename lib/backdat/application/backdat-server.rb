require 'backdat/application'
require 'backdat/client'
require 'backdat/server'

# The backdat server command line parser.
class Backdat::Application::Server < Backdat::Application

  banner """Usage: #{$0} (options)

    #{$0} SOURCE
    #{$0} SOURCE TARGET
    #{$0} [ backup|restore ] SOURCE
    #{$0} [ backup|restore ] SOURCE TARGET

    Note: Configuration for directories is checked in the following order:
          1) redis if the backdat server is running
          2) directory specific .backdat file
  """

  option :config_file,
    :short => "-c CONFIG",
    :long  => "--config CONFIG",
    :default => "/etc/backdat.rb",
    :description => "The configuration file to use"

  option :log_level,
    :short => "-l LEVEL",
    :long  => "--log_level LEVEL",
    :description => "Set the log level (debug, info, warn, error, fatal)",
    :proc => lambda { |l| l.to_sym }

  option :log_location,
    :short => "-L LOG_LOCATION",
    :long =>  "--logfile LOG_LOCATION",
    :description => "Set the log file location, defaults to STDOUT",
    :proc => nil

  option :user,
    :short => "-u USER",
    :long => "--user USER",
    :description => "User to set privilege to",
    :proc => nil

  option :group,
    :short => "-g GROUP",
    :long => "--group GROUP",
    :description => "Group to set privilege to",
    :proc => nil

  option :daemonize,
    :short => "-d",
    :long  => "--daemonize",
    :default => false,
    :description => "Run the application as a daemon (forces `-s`)",
    :proc => lambda { |p| true }

  option :environment,
    :short => "-E",
    :long  => "--environment",
    :description => "The environment profile to use",
    :proc => nil

  option :rack_host,
    :short => "-H HOSTNAME",
    :long  => "--hostname HOSTNAME",
    :description => "Hostname to listen on (default: 0.0.0.0)",
    :proc => nil

  option :rack_port,
    :short => "-P PORT",
    :long  => "--port PORT",
    :description => "Port to listen on (default: 8080)",
    :proc => lambda { |p| p.to_i }

  option :pid_file,
    :short => "-f PID_FILE",
    :long  => "--pid PID_FILE",
    :description => "Set the PID file location, defaults to /tmp/backdat.pid",
    :proc => nil

  option :json,
    :short => "-j JSON",
    :long  => "--json JSON",
    :description => "Override the default .backdat json config",
    :default => "",
    :proc => nil

  option :server,
    :short => "-s",
    :long  => "--server",
    :default => false,
    :description => "Start the application as a server",
    :boolean => true,
    :proc => nil

  option :help,
    :short => "-h",
    :long  => "--help",
    :description => "Show this message",
    :on => :tail,
    :boolean => true,
    :show_options => true,
    :exit => 0

  option :version,
    :short => "-v",
    :long  => "--version",
    :description => "Show backdat version",
    :boolean => true,
    :proc => lambda { |v| puts "backdat: #{::Backdat::VERSION}"},
    :exit => 0

  # Grabs all of the cli parameters and generates the mixlib config object.
  def initialize
    super
    Backdat::Config.merge!(config)
  end

  # Configures the backdat server based on the cli parameters.
  def setup_application
    original_dir = Dir.pwd
    Backdat::Daemon.change_privilege
    Backdat::Config[:server] = true if Backdat::Config[:daemonize]
    if Backdat::Config[:server]
      @app = Backdat::Server.new
    else
      @app = Backdat::Client.new(@commands, original_dir)
    end
  end

  # Runs the backdat server.
  def run_application
    if Backdat::Config[:daemonize]
      Backdat::Config[:server] = true
      Backdat::Daemon.daemonize("backdat")
    end
    @app.run
  end
end
