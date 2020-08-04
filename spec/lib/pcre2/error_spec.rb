RSpec.describe PCRE2::Error do
  describe ".from_error_code" do
    it "has the correct error message" do
      error = PCRE2::Error.from_error_code(PCRE2::PCRE2_ERROR_BADDATA)

      expect(error.message).to match(/bad data value/)
    end
  end
end
