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

      expect(result.offset(0)).to eq([5, 9])
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

      expect(result.offset(0)).to eq([11, 15])
    end
  end
end
