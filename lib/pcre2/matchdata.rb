class PCRE2::MatchData
  attr :regexp, :pairs, :string

  def initialize(regexp, string, pairs)
    @regexp = regexp
    @string = string
    @pairs = pairs
  end

  def [](key)
    if !key.is_a?(Numeric)
      key = regexp.named_captures[key.to_s].first
    end

    if pair = pairs[key]
      string_from_pair(*pair)
    end
  end

  def offset(n)
    pairs[n]
  end

  def capture_pairs
    pairs[1..-1]
  end

  def to_a
    @to_a ||= pairs.map { |pair| string_from_pair(*pair) }
  end

  def captures
    to_a[1..-1]
  end

  def pre_match
    string[0 ... beginning_of_match]
  end

  def post_match
    string[ending_of_match .. -1]
  end

  private

  def beginning_of_match
    offset(0)[0]
  end

  def ending_of_match
    offset(0)[1]
  end

  def string_from_pair(start, ending)
    string.slice(start, ending-start)
  end
end
