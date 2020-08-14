module PCRE2::StringUtils
  def scan(string, &block)
    return enum_for(:scan, string).to_a if !block_given?

    matches(string) do |matchdata|
      if matchdata.captures.any?
        yield matchdata.captures
      else
        yield matchdata[0]
      end
    end
  end
end
