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
    matches(string) do |matchdata|
      beginning, ending = matchdata.offset(0)

      # If zero-length match and the previous_position is equal to the match position, just skip
      # it. The next zero-length match will have a different previous_position and generate a split
      # which results in the appearance of a "per character split" but without empty parts in the
      # beginning. Note that we're also skipping adding capture groups.
      if matchdata.length == 0 && previous_position == beginning
        next
      end

      yield string[previous_position ... beginning]

      matchdata.captures.each do |capture|
        yield capture
      end

      previous_position = ending
    end

    # Also return the ending of the string from the last match
    if previous_position < string.length
      yield string[previous_position .. -1]
    end
  end
end
