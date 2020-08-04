class PCRE2::Error < StandardError
  def self.from_error_code(error_code)
    message = PCRE2::Lib.get_error_message(error_code)

    self.new("Error #{error_code}: #{message}")
  end
end
