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

  describe "#split" do
    let(:string) {  "and a 1 and a 2 and a 345 congrats!" }

    it "splits where the regexp matches" do
      regexp = PCRE2::Regexp.new('\d+')

      result = regexp.split(string)

      expect(result).to eq(["and a ", " and a ", " and a ", " congrats!"])
    end

    it "returns captures in the result too" do
      regexp = PCRE2::Regexp.new('\d(\d*)')

      result = regexp.split(string)

      expect(result).to eq(["and a ", "", " and a ", "", " and a ", "45", " congrats!"])
    end

    it "splits each character for zero-length matches" do
      regexp = PCRE2::Regexp.new('')

      result = regexp.split(string)

      expect(result).to eq(string.chars)
    end

    # These are tests that were reverse-engineered from what String#split returns, since the documentation
    # or the original source code is not very clear about what the exact specification of `split` should be
    # when there are zero-length matches.
    context "edge-cases" do
      let(:string) { "abcde" }

      it "has an empty part at the beginning" do
        regexp = PCRE2::Regexp.new("a")

        result = regexp.split(string)

        expect(result).to eq(["", "bcde"])
      end

      it "has a zero-length match so split by characters without empty part at the beginning" do
        regexp = PCRE2::Regexp.new("")

        result = regexp.split(string)

        expect(result).to eq(["a", "b", "c", "d", "e"])
      end

      it "has a zero-length match in the middle so split into two parts" do
        regexp = PCRE2::Regexp.new("(?=c)")

        result = regexp.split(string)

        expect(result).to eq(["ab", "cde"])
      end

      it "has a zero-length match at the start and in the middle but again only split into two parts without empty part at the beginning" do
        regexp = PCRE2::Regexp.new("^|(?=c)")

        result = regexp.split(string)

        expect(result).to eq(["ab", "cde"])
      end

      it "has multiple zero-length matches including empty capture groups so split by chars and also include lots of empty results" do
        regexp = PCRE2::Regexp.new("()|^|(?=c)")

        result = regexp.split(string)

        expect(result).to eq(["a", "", "b", "", "c", "", "d", "", "e"])
      end
    end
  end
end
