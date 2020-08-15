module PCRE2
  class Regexp
    attr :source, :pattern_ptr

    include StringUtils

    # Accepts a String, Regexp or another PCRE2::Regexp
    def initialize(pattern, *options)
      case pattern
      when ::Regexp, PCRE2::Regexp
        @source = pattern.source
      else
        @source = pattern
      end

      @pattern_ptr = Lib.compile_pattern(source, options)
    end

    # Compiles the Regexp into a JIT optimised version. Returns whether it was successful
    def jit!
      options = PCRE2_JIT_COMPLETE | PCRE2_JIT_PARTIAL_SOFT | PCRE2_JIT_PARTIAL_HARD

      Lib.pcre2_jit_compile_8(pattern_ptr, options) == 0
    end

    def match(str, pos = nil)
      result_count, match_data_ptr = Lib.match(@pattern_ptr, str, position: pos)

      if result_count == 0
        nil
      else
        pairs = PCRE2::Lib.get_ovector_pairs(match_data_ptr, result_count)

        MatchData.new(self, str, pairs)
      end
    end

    def matches(str, pos = nil, &block)
      return enum_for(:matches, str, pos) if !block_given?

      pos ||= 0
      while pos < str.length
        matchdata = self.match(str, pos)

        if matchdata
          yield matchdata

          beginning, ending = matchdata.offset(0)

          if pos == ending # Manually increment position if no change to avoid infinite loops
            pos += 1
          else
            pos = ending
          end
        else
          return
        end
      end
    end

    def named_captures
      @named_captures ||= Lib.named_captures(pattern_ptr)
    end

    def names
      named_captures.keys
    end
  end
end
