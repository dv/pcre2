class PCRE2::MatchData
  attr_accessor :pairs

  def self.from_match_data_pointer(match_data_ptr, result_count = nil)
    match_pair, *capture_pairs = PCRE2::Lib.get_ovector_pairs(match_data_ptr, result_count)

    md = PCRE2::MatchData.new
    md.pairs = [match_pair] + capture_pairs

    md
  end

  def offset(n)
    pairs[n]
  end

  def capture_pairs
    pairs[1..-1]
  end
end
