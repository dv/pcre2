RSpec.describe PCRE2::StringUtils do
  describe "#scan" do
    it "returns all matched strings" do
      subject = "and a 1 and a 2 and a 345"
      regexp = PCRE2::Regexp.new('\d+')

      result = regexp.scan(subject)

      expect(result).to eq(["1", "2", "345"])
    end

    it "accepts a block which iterates over all matches" do
      subject = "and a 1 and a 2 and a 345"
      regexp = PCRE2::Regexp.new('\d+')

      result = ""
      regexp.scan(subject) { |match| result += match }

      expect(result).to eq("12345")
    end

    it "returns captures if arity is higher than 1" do
      subject = "and a 1 and a 2 and a 345"
      regexp = PCRE2::Regexp.new('(and a) (\d+)')

      result = regexp.scan(subject)

      expect(result).to eq([["and a", "1"], ["and a", "2"], ["and a", "345"]])
    end
  end
end
