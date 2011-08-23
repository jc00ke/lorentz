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

  def rename(key, newkey)
    if key == newkey
      raise LorentzException, "newkey: #{newkey} must be different than key: #{key}"
    end
    raise LorentzException, "key: #{key} does not exist" unless exists(key)
    save do
      val = get(key)
      del(key)
      set(newkey, val)
    end
  end

  def renamenx(key, newkey)
    if key == newkey
      raise LorentzException, "newkey: #{newkey} must be different than key: #{key}"
    end
    raise LorentzException, "key: #{key} does not exist" unless exists(key)
    return 0 if exists(newkey)
    rename(key, newkey)
    return 1
  end

end
