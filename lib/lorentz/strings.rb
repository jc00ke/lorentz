module Lorentz::Strings
  def set(key, value)
    save do
      @db[key] = value
      return "OK"
    end
  end

  def get(key)
    @db[key]
  end
end
