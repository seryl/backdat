source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

gem "yajl-ruby", "~> 1.1.0"
gem "eventmachine", "~> 1.0.0.rc.4"
gem "em-synchrony", "~> 0.2.0"
gem "redis", "~> 3.0.1"

gem "tilt", "~> 1.3.3"

gem "mixlib-cli", ">= 1.2.2"
gem "mixlib-config", ">= 1.1.0"
gem "mixlib-log", ">= 1.3.0"

gem "puma", "~> 1.5.0"
gem "rack", "~> 1.4.1"
gem "sinatra", "~> 1.3.2"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "rspec", "~> 2.10.0"
  gem "yard", "~> 0.8"
  gem "cucumber", ">= 0"
  gem "bundler", "~> 1.1.0"
  gem "jeweler", "~> 1.8.3"
  gem "fakefs", "~> 0.4.0"
  gem "redcarpet", "~> 2.1.1"
  gem (RUBY_VERSION =~ /^1\.9/ ? "simplecov" : "rcov"), ">= 0"
end
