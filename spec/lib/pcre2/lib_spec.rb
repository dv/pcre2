RSpec.describe PCRE2::Lib do
  describe ".get_error_message" do
    it "returns an error message" do
      result = PCRE2::Lib.get_error_message(PCRE2::PCRE2_ERROR_NOMATCH)

      expect(result).to eq("no match")
    end

    it "accepts a MemoryPointer" do
      error_code = FFI::MemoryPointer.new(:int8, 1)
      error_code.write_int8(PCRE2::PCRE2_ERROR_NOMATCH)

      result = PCRE2::Lib.get_error_message(error_code)

      expect(result).to eq("no match")
    end
  end
end
