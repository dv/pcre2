module PCRE2::StringUtils
  def scan(string, &block)
    return enum_for(:scan, string).to_a if !block_given?

    pos = 0
    while pos < string.length
      matchdata = self.match(string, pos)

      if matchdata
        if matchdata.captures.any?
          yield matchdata.captures
        else
          yield matchdata[0]
        end

        pos = matchdata.offset(0)[1]
      else
        return
      end
    end
  end
end
