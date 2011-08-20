require 'lorentz/glob'

module Lorentz::Keys
  include Lorentz::Glob

  def exists(key)
    run do
      !!@db[key]
    end
  end

  def del(*keys)
    run do
      keys.map{ |k| @db.delete(k) }.compact.size
    end
  end

  def keys(pattern)
    run do
      @db.keys.grep(compile(pattern))
    end
  end
end
