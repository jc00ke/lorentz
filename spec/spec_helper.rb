require 'rubygems'
require 'bundler'

begin
  Bundler.require(:default, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle` to install missing gems"
  exit e.status_code
end

require 'lorentz'
require 'rspec'
