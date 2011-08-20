module Lorentz::Glob
  # jacked from https://github.com/karottenreibe/joker
  # & specifically http://karottenreibe.github.com/2009/12/03/inside-the-joker/
  def compile(source, case_sensitive=false)
    ptr = 0
    compiled = '^'
    while ptr < source.length
      snip = source[ptr..ptr]
      case snip
      when '\\'
        lookahead = source[ptr+1..ptr+1]
        case snip
        when '\\\\', '\\?', '\\*'
          compiled << snip << lookahead
        else
          compiled << Regexp.quote(lookahead)
        end
        ptr += 1
      when '?' then compiled << '.'
      when '*' then compiled << '.*'
      when '[' then compiled << '['
      when ']' then compiled << ']'
      else          compiled << Regexp.quote(snip)
      end
      ptr += 1
    end
    compiled << '$'
    Regexp.compile(compiled, case_sensitive)
  end

  module_function :compile
end
