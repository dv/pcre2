class PCRE2::Regexp
  attr :source

  def initialize(pattern)
    @source = pattern
    @pattern_ptr = PCRE2::Lib.compile_pattern(pattern)
  end

  def match(str, pos = nil)
    result_count, match_data_ptr = PCRE2::Lib.match(@pattern_ptr, str, position: pos)

    if result_count == 0
      nil
    else
      PCRE2::MatchData.from_match_data_pointer(match_data_ptr, result_count)
    end
  end
end
