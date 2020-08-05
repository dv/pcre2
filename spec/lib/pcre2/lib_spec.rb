RSpec.describe PCRE2::Lib do
  describe ".get_error_message" do
    it "returns an error message" do
      result = PCRE2::Lib.get_error_message(PCRE2::PCRE2_ERROR_NOMATCH)

      expect(result).to eq("no match")
    end

    it "accepts a MemoryPointer" do
      error_code = FFI::MemoryPointer.new(:int, 1)
      error_code.write_int(PCRE2::PCRE2_ERROR_NOMATCH)

      result = PCRE2::Lib.get_error_message(error_code)

      expect(result).to eq("no match")
    end
  end

  describe ".match" do
    it "returns 0 when no matches" do
      pattern_ptr = PCRE2::Lib.compile_pattern("hello")
      result_count, match_data_ptr = PCRE2::Lib.match(pattern_ptr, "goodbye")

      expect(result_count).to eq(0)
    end
  end

  describe ".compile_pattern" do
    errors = {
      '(?<>.' => /Error 162: subpattern name expected/,
      '(.*'   => /Error 114: missing closing parenthesis/,
    }

    errors.each do |pattern, error|
      it "raises the correct error for '#{pattern}'" do
        expect { PCRE2::Lib.compile_pattern(pattern) }.to raise_error(PCRE2::Error, error)
      end
    end
  end
end
