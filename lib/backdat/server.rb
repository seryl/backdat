require 'puma'
require 'eventmachine'
require 'backdat/http'

# The backdat server and management daemon.
class Backdat::Server

  # Creates a new backdat server.
  def initialize
  end

  # Runs the server.
  def run
    if Backdat::Config[:server]
      EM.run do
        @app = Rack::Builder.new do
          use Rack::Lint
          use Rack::ShowExceptions
          run Rack::Cascade.new([Backdat::Http])
        end.to_app

        Rack::Handler.get(:puma).run(@app, rack_options)
      end
    end
  end

  # Gets the rack options from the configuration.
  # 
  # @return [ Hash ] The rack options from Backdat::Config.
  def rack_options
    opts = Hash.new
    Backdat::Config.configuration.each do |k,v|
      if /^rack/ =~ k.to_s
        param = k.to_s.gsub('rack_', '')

        case param
        when "environment"
          opts[param.to_sym] = v
        else
          opts[param.capitalize.to_sym] = v
        end
      end
    end
    opts
  end
  
end
