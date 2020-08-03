class PCRE2::Regexp
  attr :source

  def initialize(pattern)
    @source = pattern
  end

  def match(str)
    ::Regexp.new(source).match(str)
  end
end
