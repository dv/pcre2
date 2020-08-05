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
    pairs.map { |pair| string_from_pair(*pair) }
  end

  def captures
    to_a[1..-1]
  end

  private

  def string_from_pair(start, ending)
    string.slice(start, ending-start)
  end
end
