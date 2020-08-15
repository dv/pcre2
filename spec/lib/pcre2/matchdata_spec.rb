RSpec.describe PCRE2::MatchData do
  let(:pattern) { "(?<a>hello) (world)" }
  let(:string) { "one two three hello world today!" }
  let(:re) { PCRE2::Regexp.new(pattern) }

  subject(:matchdata) { re.match(string) }

  describe "#[]" do
    it "returns the full match at 0" do
      expect(matchdata[0]).to eq("hello world")
    end

    it "returns the subpattern match at 1" do
      expect(matchdata[1]).to eq("hello")
    end

    it "returns the subpattern match at 2" do
      expect(matchdata[2]).to eq("world")
    end

    it "returns nil for unexisting subpattern" do
      expect(matchdata[3]).to be_nil
    end

    it "returns the named subpattern match at 'a'" do
      expect(matchdata["a"]).to eq("hello")
    end
  end

  describe "#to_a" do
    it "returns an array of all matches" do
      expect(matchdata.to_a).to eq(["hello world", "hello", "world"])
    end
  end

  describe "#pre_match and #post_match" do
    it "returns the correct results" do
      expect(matchdata.pre_match).to eq("one two three ")
      expect(matchdata.post_match).to eq(" today!")
    end
  end

  describe "#length" do
    it "returns 0 for a zero-length match" do
      re = PCRE2::Regexp.new("")
      matchdata = re.match("string")

      expect(matchdata.length).to eq(0)
    end
  end
end
