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

RSpec.configure do |config|
  config.before(:each) do
    ::Maglev.abort_transaction
    ::Maglev::PERSISTENT_ROOT.delete_if do |key, val|
      key.to_s =~ /^lorentz_db_.*$/
    end
    ::Maglev.commit_transaction
  end
end
