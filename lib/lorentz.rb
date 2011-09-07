require 'maglev/rchash'
require "lorentz/version"
require "lorentz/exceptions"
require "lorentz/strings"
require "lorentz/keys"

class Lorentz

  attr_reader :db
  def initialize(opts={})
    db_name = opts.delete(:db) || 0

    @db = begin
            ::Maglev::PERSISTENT_ROOT[:"lorentz_db_#{db_name}"] ||= RCHash.new
          rescue
            $stderr.puts "Maglev only"
            exit
          end
  end
  include Lorentz::Strings
  include Lorentz::Keys

  private
  def save(&block)
    begin
      Maglev.abort_transaction
      yield
      Maglev.commit_transaction
    rescue Maglev::CommitFailedException
      $stderr.puts "I tried to save but I couldn't. Trying again."
      redo
    end
  end

  def run(&block)
    Maglev.abort_transaction
    yield
  end
end
