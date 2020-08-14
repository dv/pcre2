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

  def split(string, &block)
    return enum_for(:split, string).to_a if !block_given?

    previous_position = 0
    matches(string).each do |matchdata|
      beginning, ending = matchdata.offset(0)

      yield string[previous_position ... beginning]

      if matchdata.captures.any?
        matchdata.captures.each do |capture|
          yield capture
        end
      end

      previous_position = ending
    end
  end
end
