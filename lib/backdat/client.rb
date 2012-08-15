# The client proxy class.
require 'faraday'

class Backdat::Client
  attr_accessor :connection, :site

  def initialize
    @connection = Faraday::Connection.new("http://google.com/")
  end

  def request(verb, url, params={}, headers={})
    resp = @connection.run_request(verb, url, nil, headers) do |req|
      req.params.update(params)
    end
    case resp.status
    when 200...201 then resp.body
    when 301
      puts @connection.params
    when 401
      e = Backdat::Exceptions::AccessDenied.new("Received HTTP 401")
      raise e
    else
      e = Backdat::Exceptions::HTTPError.new("Received HTTP #{resp.status}")
      raise e
    end
  end
end

p Backdat::Client.new.request(:get, "/34")
