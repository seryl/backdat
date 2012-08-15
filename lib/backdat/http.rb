require 'sinatra/base'

# The sinatra 
class Backdat::Http < Sinatra::Base

  get '/' do
    "Hello world"
  end
end
