module Lorentz::Strings
  def set(key, value)
    save do
      @db[key] = value
      return "OK"
    end
  end

  def get(key)
    run do
      @db[key]
    end
  end

  def strlen(key)
    val = get(key)
    return 0 unless val
    if val.kind_of?(String)
      return val.length
    else
      raise LorentzException, "The value stored at key: #{key} is not a String"
    end
  end
end
