module Lorentz::Keys
  def exists(key)
    !!@db[key]
  end

  def del(*keys)
    keys.map{ |k| @db.delete(k) }.compact.size
  end
end
