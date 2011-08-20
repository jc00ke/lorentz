require 'lorentz/glob'

module Lorentz::Keys
  include Lorentz::Glob

  def exists(key)
    !!@db[key]
  end

  def del(*keys)
    keys.map{ |k| @db.delete(k) }.compact.size
  end

  def keys(pattern)
    @db.keys.grep(compile(pattern))
  end
end
