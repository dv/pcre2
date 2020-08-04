require "ffi"

module PCRE2::Lib
  extend FFI::Library

  ffi_lib 'pcre2-8'     # Able to do 16 or 32 too

  typedef :size_t, :PCRE2_SIZE

  # int pcre2_get_error_message(int errorcode, PCRE2_UCHAR *buffer, PCRE2_SIZE bufflen);
  attach_function :pcre2_get_error_message_8, [ :int, :pointer, :PCRE2_SIZE ], :int

  def self.get_error_message(error_code)
    if error_code.kind_of?(FFI::MemoryPointer)
      error_code = error_code.get_int8(0)
    end

    buffer = FFI::MemoryPointer.new(:uint8_t, 120) # should be PCRE2_UCHAR
    result = pcre2_get_error_message_8(error_code, buffer, buffer.size)

    case result
    when PCRE2::PCRE2_ERROR_BADDATA
      raise PCRE2::Error, "Error number #{error_code} unknown"
    when PCRE2::PCRE2_ERROR_NOMEMORY
      raise PCRE2::Error, "Buffer of #{buffer.size} is not large enough to contain message"
    end

    buffer.read_string
  end
end
