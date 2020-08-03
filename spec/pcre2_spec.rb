RSpec.describe PCRE2 do
  it "has a version number" do
    expect(PCRE2::VERSION).not_to be nil
  end

  it "does something useful" do
    regexp = PCRE2::Regexp.new("hello")

    matchdata = regexp.match("this is a hello world!")

    expect(matchdata.offset(0)).to eq([10, 15])
  end
end
