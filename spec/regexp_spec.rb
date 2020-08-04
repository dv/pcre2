RSpec.describe Regexp do
  it "responds to `to_pcre2`", :skip do
    regexp = /hello/

    pcre2_regexp = regexp.to_pcre2

    expect(pcre2_regexp).to be_a(PCRE2::Regexp)
    expect(pcre2_regexp.source).to eq(regexp.source)
  end
end
