class PCRE2::Error < StandardError
  def self.from_error_code(error_code, extra_message = nil)
    message = "Error #{error_code}: "
    message += PCRE2::Lib.get_error_message(error_code)
    message += " - #{extra_message}" if extra_message

    self.new(message)
  end
end
