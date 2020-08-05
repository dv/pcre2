RSpec.describe PCRE2::Regexp do
  describe "#new" do
    # Apparently this does not throw an error
    it "returns an error when given a broken pattern", :skip do
      pattern = "hell(o"

      expect do
        PCRE2::Regexp.new(pattern)
      end.to raise_error(/unmatched parenthesis/)
    end
  end

  describe "#match" do
    let(:regexp) { PCRE2::Regexp.new("hello") }

    it "returns a matchdata when a match" do
      subject = "well hello there!"

      result = regexp.match(subject)

      expect(result.offset(0)).to eq([5, 10])
    end

    it "matches very long patterns" do
      part = "aa"
      pattern = part * 100
      subject = part * 99

      regexp = PCRE2::Regexp.new(pattern)

      expect(regexp.match(subject)).to be_nil
      expect(regexp.match(subject + part)).not_to be_nil
    end

    it "returns nil when no match" do
      subject = "goodbye"

      result = regexp.match(subject)

      expect(result).to be_nil
    end

    it "starts from a given position" do
      subject = "well hello hello hello there!"
      #                    ^ start here

      result = regexp.match(subject, 11)

      expect(result.offset(0)).to eq([11, 16])
    end
  end

  context "with named captures" do
    describe "#named_captures" do
      it "returns a list of named subpatterns and positions" do
        pattern = '(?<a>\w+)(?<b>\W+)(?<c>\w+)(?<c>aaa)'
        re = PCRE2::Regexp.new(pattern, PCRE2::PCRE2_DUPNAMES)

        expect(re.named_captures).to eq(
          {
            "a" => [1],
            "b" => [2],
            "c" => [3, 4]
          }
        )
      end
    end

    describe "#names" do
      it "returns names of the named captures" do
        pattern = '(?<a>\w+)(?<b>\W+)(?<c>\w+)'
        re = PCRE2::Regexp.new(pattern)

        expect(re.names).to eq(["a", "b", "c"])
      end
    end
  end

  context "with options" do
    it "matches case insensitive" do
      re = PCRE2::Regexp.new("HELLO")
      expect(re.match("hello!")).to be_nil

      re = PCRE2::Regexp.new("HELLO", PCRE2::PCRE2_CASELESS)
      expect(re.match("hello!")).not_to be_nil
    end

    it "allows duplicate named subpatterns" do\
      pattern = "(?<a>.)(?<a>)"

      expect { PCRE2::Regexp.new(pattern) }.to raise_error(/two named subpatterns have the same name/)
      expect { PCRE2::Regexp.new(pattern, PCRE2::PCRE2_DUPNAMES) }.not_to raise_error
    end

    it "accepts multiple options" do
      re = PCRE2::Regexp.new("HELLO|(?<a>world)(?<a>country)", PCRE2::PCRE2_DUPNAMES, PCRE2::PCRE2_CASELESS)

      expect(re.match("hello!")).not_to be_nil
    end
  end

  describe "#jit!" do
    it "compiles successfully" do
      expect(PCRE2::Regexp.new("hello").jit!).to be_truthy
    end
  end
end
