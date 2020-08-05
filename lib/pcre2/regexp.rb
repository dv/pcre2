class PCRE2::Regexp
  attr :source, :pattern_ptr

  def initialize(pattern, *options)
    @source = pattern
    @pattern_ptr = PCRE2::Lib.compile_pattern(pattern, options)
  end

  # Compiles the Regexp into a JIT optimised version. Returns whether it was successful
  def jit!
    options = PCRE2::PCRE2_JIT_COMPLETE | PCRE2::PCRE2_JIT_PARTIAL_SOFT | PCRE2::PCRE2_JIT_PARTIAL_HARD

    PCRE2::Lib.pcre2_jit_compile_8(pattern_ptr, options) == 0
  end

  def match(str, pos = nil)
    result_count, match_data_ptr = PCRE2::Lib.match(@pattern_ptr, str, position: pos)

    if result_count == 0
      nil
    else
      pairs = PCRE2::Lib.get_ovector_pairs(match_data_ptr, result_count)

      PCRE2::MatchData.new(self, str, pairs)
    end
  end

  def named_captures
    @named_captures ||= PCRE2::Lib.named_captures(pattern_ptr)
  end

  def names
    named_captures.keys
  end
end
