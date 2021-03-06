require "ffi"

module PCRE2::Lib
  RETURN_CODE_NO_ERROR = 100

  extend FFI::Library

  ffi_lib 'pcre2-8'     # Able to do 16 or 32 too

  PCRE2_SIZE    = typedef :size_t,   :PCRE2_SIZE
  PCRE2_SPTR    = typedef :pointer,  :PCRE2_SPTR
  PCRE2_UCHAR8  = typedef :uint8_t,  :PCRE2_UCHAR8
  PCRE2_UCHAR16 = typedef :uint16_t, :PCRE2_UCHAR16
  PCRE2_UCHAR32 = typedef :uint32_t, :PCRE2_UCHAR32

  # For 8-bit PCRE
  PCRE2_UCHAR   = typedef :PCRE2_UCHAR8, :PCRE2_UCHAR

  # int pcre2_get_error_message(int errorcode, PCRE2_UCHAR *buffer, PCRE2_SIZE bufflen);
  attach_function :pcre2_get_error_message_8, [ :int, :pointer, :PCRE2_SIZE ], :int

  # pcre2_code *pcre2_compile(PCRE2_SPTR pattern, PCRE2_SIZE length, uint32_t options, int *errorcode, PCRE2_SIZE *erroroffset, pcre2_compile_context *ccontext);
  attach_function :pcre2_compile_8, [ :PCRE2_SPTR, :PCRE2_SIZE, :uint32_t, :pointer, :pointer, :pointer ], :pointer
  attach_function :pcre2_code_free_8, [ :pointer ], :void

  # int pcre2_pattern_info(const pcre2_code *code, uint32_t what, void *where);
  attach_function :pcre2_pattern_info_8, [ :pointer, :uint32_t, :pointer ], :int

  # pcre2_match_data *pcre2_match_data_create_from_pattern( const pcre2_code *code, pcre2_general_context *gcontext);
  attach_function :pcre2_match_data_create_from_pattern_8, [ :pointer, :pointer ], :pointer
  attach_function :pcre2_match_data_free_8, [ :pointer ], :void

  # int pcre2_match(const pcre2_code *code, PCRE2_SPTR subject, PCRE2_SIZE length, PCRE2_SIZE startoffset, uint32_t options, pcre2_match_data *match_data, pcre2_match_context *mcontext);
  attach_function :pcre2_match_8, [ :pointer, :PCRE2_SPTR, :PCRE2_SIZE, :PCRE2_SIZE, :uint32_t, :pointer, :pointer ], :int

  attach_function :pcre2_get_ovector_count_8, [ :pointer ], :uint32_t
  attach_function :pcre2_get_ovector_pointer_8, [ :pointer ], :pointer

  # int pcre2_jit_compile(pcre2_code *code, uint32_t options)
  attach_function :pcre2_jit_compile_8, [ :pointer, :uint32_t ], :int


  def self.get_error_message(error_code)
    if error_code.kind_of?(FFI::MemoryPointer)
      error_code = error_code.read_int
    end

    buffer = FFI::MemoryPointer.new(PCRE2_UCHAR, 120)
    result = pcre2_get_error_message_8(error_code, buffer, buffer.size)

    case result
    when PCRE2::PCRE2_ERROR_BADDATA
      "Error number #{error_code} unknown"
    when PCRE2::PCRE2_ERROR_NOMEMORY
      raise PCRE2::Error, "Buffer of #{buffer.size} is not large enough to contain message"
    else
      buffer.read_string
    end
  end

  # Some utility functions to help make the above more palatable
  def self.compile_pattern(pattern, options = [])
    pattern_string_ptr = FFI::MemoryPointer.from_string(pattern)
    error_code_ptr     = FFI::MemoryPointer.new(:int, 1)
    error_offset_ptr   = FFI::MemoryPointer.new(PCRE2_SIZE, 1)
    options            = options.flatten.inject(0) { |memo, option| memo | option }

    pattern_ptr = PCRE2::Lib.pcre2_compile_8(pattern_string_ptr, pattern.size, options, error_code_ptr, error_offset_ptr, nil)

    if pattern_ptr.null?
      error_code = error_code_ptr.read_int
      error_offset = error_offset_ptr.read(PCRE2_SIZE)

      raise PCRE2::Error.from_error_code(error_code, "while compiling pattern #{pattern} @ #{error_offset}")
    end

    FFI::AutoPointer.new(pattern_ptr, PCRE2::Lib.method(:pcre2_code_free_8))
  end

  def self.create_match_data_for_pattern(pattern_ptr)
    match_data_ptr = PCRE2::Lib.pcre2_match_data_create_from_pattern_8(pattern_ptr, nil)
    FFI::AutoPointer.new(match_data_ptr, PCRE2::Lib.method(:pcre2_match_data_free_8))
  end

  def self.match(pattern_ptr, body, position: 0, match_data_ptr: nil)
    position ||= 0
    match_data_ptr ||= create_match_data_for_pattern(pattern_ptr)

    body_ptr = FFI::MemoryPointer.from_string(body)

    return_code =
      PCRE2::Lib.pcre2_match_8(
        pattern_ptr,
        body_ptr,
        body_ptr.size,
        position,
        0,
        match_data_ptr,
        nil
      )

    case return_code
    when 0
      raise PCRE2::Error, "Not enough memory in MatchData to store all captures"
    when PCRE2::PCRE2_ERROR_NOMATCH
      result_count = 0
    else
      if return_code < 0
        raise PCRE2::Error.from_error_code(return_code)
      else
        result_count = return_code
      end
    end

    [result_count, match_data_ptr]
  end

  def self.get_ovector_pairs(match_data_ptr, pair_count)
    if pair_count.nil?
      pair_count = PCRE2::Lib.pcre2_get_ovector_count_8(match_data_ptr)
    end

    ovector_ptr = PCRE2::Lib.pcre2_get_ovector_pointer_8(match_data_ptr)
    type_size = FFI.type_size(:size_t)

    pair_count.times.map do |i|
      [
        ovector_ptr.get(:size_t, i*2 * type_size),
        ovector_ptr.get(:size_t, (i*2+1) * type_size)
      ]
    end
  end

  def self.named_captures(pattern_ptr)
    named_captures_count = FFI::MemoryPointer.new(:uint32_t, 1)
    name_entry_size      = FFI::MemoryPointer.new(:uint32_t, 1)
    name_table_ptr       = FFI::MemoryPointer.new(:pointer, 1)

    if PCRE2::Lib.pcre2_pattern_info_8(pattern_ptr, PCRE2::PCRE2_INFO_NAMECOUNT, named_captures_count) != 0
      raise "Something went wrong"
    end

    if PCRE2::Lib.pcre2_pattern_info_8(pattern_ptr, PCRE2::PCRE2_INFO_NAMEENTRYSIZE, name_entry_size) != 0
      raise "Something went wrong"
    end

    if PCRE2::Lib.pcre2_pattern_info_8(pattern_ptr, PCRE2::PCRE2_INFO_NAMETABLE, name_table_ptr) != 0
      raise "Something went wrong"
    end

    named_captures_count = named_captures_count.read_uint32
    name_entry_size      = name_entry_size.read_uint32
    name_table_ptr       = name_table_ptr.read_pointer

    names_and_positions =
      named_captures_count.times.map do |i|
        ovector_position = (name_table_ptr.get_int8(0) << 8) + name_table_ptr.get_int8(1)
        match_name = (name_table_ptr+2).read_string_to_null

        name_table_ptr += name_entry_size

        [match_name, ovector_position]
      end

    # Convert an array of [name, position] into a Hash of name => [position (, position, ...)], with possible duplicate names
    names_and_positions.each_with_object(Hash.new {[]} ) { |(name, position), hash| hash[name] <<= position }
  end
end
