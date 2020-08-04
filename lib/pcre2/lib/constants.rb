#
# Use replace:
#
#   "#define ([^\W]+) \W* (.*)/"" -> "\1 = \2"
#   "(0x[^u]+)u"                  -> "\1"
#
module PCRE2
  # The following option bits can be passed to pcre2_compile(), pcre2_match(),
  # or pcre2_dfa_match(). PCRE2_NO_UTF_CHECK affects only the function to which it
  # is passed. Put these bits at the most significant end of the options word so
  # others can be added next to them

  PCRE2_ANCHORED                             = 0x80000000
  PCRE2_NO_UTF_CHECK                         = 0x40000000
  PCRE2_ENDANCHORED                          = 0x20000000

  # The following option bits can be passed only to pcre2_compile(). However,
  # they may affect compilation, JIT compilation, and/or interpretive execution.
  # The following tags indicate which:
  # C   alters what is compiled by pcre2_compile()
  # J   alters what is compiled by pcre2_jit_compile()
  # M   is inspected during pcre2_match() execution
  # D   is inspected during pcre2_dfa_match() execution

  PCRE2_ALLOW_EMPTY_CLASS                    = 0x00000001  # C
  PCRE2_ALT_BSUX                             = 0x00000002  # C
  PCRE2_AUTO_CALLOUT                         = 0x00000004  # C
  PCRE2_CASELESS                             = 0x00000008  # C
  PCRE2_DOLLAR_ENDONLY                       = 0x00000010  #   J M D
  PCRE2_DOTALL                               = 0x00000020  # C
  PCRE2_DUPNAMES                             = 0x00000040  # C
  PCRE2_EXTENDED                             = 0x00000080  # C
  PCRE2_FIRSTLINE                            = 0x00000100  #   J M D
  PCRE2_MATCH_UNSET_BACKREF                  = 0x00000200  # C J M
  PCRE2_MULTILINE                            = 0x00000400  # C
  PCRE2_NEVER_UCP                            = 0x00000800  # C
  PCRE2_NEVER_UTF                            = 0x00001000  # C
  PCRE2_NO_AUTO_CAPTURE                      = 0x00002000  # C
  PCRE2_NO_AUTO_POSSESS                      = 0x00004000  # C
  PCRE2_NO_DOTSTAR_ANCHOR                    = 0x00008000  # C
  PCRE2_NO_START_OPTIMIZE                    = 0x00010000  #   J M D
  PCRE2_UCP                                  = 0x00020000  # C J M D
  PCRE2_UNGREEDY                             = 0x00040000  # C
  PCRE2_UTF                                  = 0x00080000  # C J M D
  PCRE2_NEVER_BACKSLASH_C                    = 0x00100000  # C
  PCRE2_ALT_CIRCUMFLEX                       = 0x00200000  #   J M D
  PCRE2_ALT_VERBNAMES                        = 0x00400000  # C
  PCRE2_USE_OFFSET_LIMIT                     = 0x00800000  #   J M D
  PCRE2_EXTENDED_MORE                        = 0x01000000  # C
  PCRE2_LITERAL                              = 0x02000000  # C

  # An additional compile options word is available in the compile context.

  PCRE2_EXTRA_ALLOW_SURROGATE_ESCAPES        = 0x00000001  # C
  PCRE2_EXTRA_BAD_ESCAPE_IS_LITERAL          = 0x00000002  # C
  PCRE2_EXTRA_MATCH_WORD                     = 0x00000004  # C
  PCRE2_EXTRA_MATCH_LINE                     = 0x00000008  # C
  PCRE2_EXTRA_ESCAPED_CR_IS_LF               = 0x00000010  # C
  PCRE2_EXTRA_ALT_BSUX                       = 0x00000020  # C

  # These are for pcre2_jit_compile().

  PCRE2_JIT_COMPLETE                         = 0x00000001  # For full matching
  PCRE2_JIT_PARTIAL_SOFT                     = 0x00000002
  PCRE2_JIT_PARTIAL_HARD                     = 0x00000004
  PCRE2_JIT_INVALID_UTF                      = 0x00000100

  # These are for pcre2_match(), pcre2_dfa_match(), pcre2_jit_match(), and
  # pcre2_substitute(). Some are allowed only for one of the functions, and in
  # these cases it is noted below. Note that PCRE2_ANCHORED, PCRE2_ENDANCHORED and
  # PCRE2_NO_UTF_CHECK can also be passed to these functions (though
  # pcre2_jit_match() ignores the latter since it bypasses all sanity checks).

  PCRE2_NOTBOL                               = 0x00000001
  PCRE2_NOTEOL                               = 0x00000002
  PCRE2_NOTEMPTY                             = 0x00000004  # ) These two must be kept
  PCRE2_NOTEMPTY_ATSTART                     = 0x00000008  # ) adjacent to each other.
  PCRE2_PARTIAL_SOFT                         = 0x00000010
  PCRE2_PARTIAL_HARD                         = 0x00000020
  PCRE2_DFA_RESTART                          = 0x00000040  # pcre2_dfa_match() only
  PCRE2_DFA_SHORTEST                         = 0x00000080  # pcre2_dfa_match() only
  PCRE2_SUBSTITUTE_GLOBAL                    = 0x00000100  # pcre2_substitute() only
  PCRE2_SUBSTITUTE_EXTENDED                  = 0x00000200  # pcre2_substitute() only
  PCRE2_SUBSTITUTE_UNSET_EMPTY               = 0x00000400  # pcre2_substitute() only
  PCRE2_SUBSTITUTE_UNKNOWN_UNSET             = 0x00000800  # pcre2_substitute() only
  PCRE2_SUBSTITUTE_OVERFLOW_LENGTH           = 0x00001000  # pcre2_substitute() only
  PCRE2_NO_JIT                               = 0x00002000  # Not for pcre2_dfa_match()
  PCRE2_COPY_MATCHED_SUBJECT                 = 0x00004000

  # Options for pcre2_pattern_convert().

  PCRE2_CONVERT_UTF                          = 0x00000001
  PCRE2_CONVERT_NO_UTF_CHECK                 = 0x00000002
  PCRE2_CONVERT_POSIX_BASIC                  = 0x00000004
  PCRE2_CONVERT_POSIX_EXTENDED               = 0x00000008
  PCRE2_CONVERT_GLOB                         = 0x00000010
  PCRE2_CONVERT_GLOB_NO_WILD_SEPARATOR       = 0x00000030
  PCRE2_CONVERT_GLOB_NO_STARSTAR             = 0x00000050

  # Newline and \R settings, for use in compile contexts. The newline values
  # must be kept in step with values set in config.h and both sets must all be
  # greater than zero.

  PCRE2_NEWLINE_CR                           = 1
  PCRE2_NEWLINE_LF                           = 2
  PCRE2_NEWLINE_CRLF                         = 3
  PCRE2_NEWLINE_ANY                          = 4
  PCRE2_NEWLINE_ANYCRLF                      = 5
  PCRE2_NEWLINE_NUL                          = 6
  PCRE2_BSR_UNICODE                          = 1
  PCRE2_BSR_ANYCRLF                          = 2

  # Error codes for pcre2_compile(). Some of these are also used by
  # pcre2_pattern_convert().

  PCRE2_ERROR_END_BACKSLASH                  = 101
  PCRE2_ERROR_END_BACKSLASH_C                = 102
  PCRE2_ERROR_UNKNOWN_ESCAPE                 = 103
  PCRE2_ERROR_QUANTIFIER_OUT_OF_ORDER        = 104
  PCRE2_ERROR_QUANTIFIER_TOO_BIG             = 105
  PCRE2_ERROR_MISSING_SQUARE_BRACKET         = 106
  PCRE2_ERROR_ESCAPE_INVALID_IN_CLASS        = 107
  PCRE2_ERROR_CLASS_RANGE_ORDER              = 108
  PCRE2_ERROR_QUANTIFIER_INVALID             = 109
  PCRE2_ERROR_INTERNAL_UNEXPECTED_REPEAT     = 110
  PCRE2_ERROR_INVALID_AFTER_PARENS_QUERY     = 111
  PCRE2_ERROR_POSIX_CLASS_NOT_IN_CLASS       = 112
  PCRE2_ERROR_POSIX_NO_SUPPORT_COLLATING     = 113
  PCRE2_ERROR_MISSING_CLOSING_PARENTHESIS    = 114
  PCRE2_ERROR_BAD_SUBPATTERN_REFERENCE       = 115
  PCRE2_ERROR_NULL_PATTERN                   = 116
  PCRE2_ERROR_BAD_OPTIONS                    = 117
  PCRE2_ERROR_MISSING_COMMENT_CLOSING        = 118
  PCRE2_ERROR_PARENTHESES_NEST_TOO_DEEP      = 119
  PCRE2_ERROR_PATTERN_TOO_LARGE              = 120
  PCRE2_ERROR_HEAP_FAILED                    = 121
  PCRE2_ERROR_UNMATCHED_CLOSING_PARENTHESIS  = 122
  PCRE2_ERROR_INTERNAL_CODE_OVERFLOW         = 123
  PCRE2_ERROR_MISSING_CONDITION_CLOSING      = 124
  PCRE2_ERROR_LOOKBEHIND_NOT_FIXED_LENGTH    = 125
  PCRE2_ERROR_ZERO_RELATIVE_REFERENCE        = 126
  PCRE2_ERROR_TOO_MANY_CONDITION_BRANCHES    = 127
  PCRE2_ERROR_CONDITION_ASSERTION_EXPECTED   = 128
  PCRE2_ERROR_BAD_RELATIVE_REFERENCE         = 129
  PCRE2_ERROR_UNKNOWN_POSIX_CLASS            = 130
  PCRE2_ERROR_INTERNAL_STUDY_ERROR           = 131
  PCRE2_ERROR_UNICODE_NOT_SUPPORTED          = 132
  PCRE2_ERROR_PARENTHESES_STACK_CHECK        = 133
  PCRE2_ERROR_CODE_POINT_TOO_BIG             = 134
  PCRE2_ERROR_LOOKBEHIND_TOO_COMPLICATED     = 135
  PCRE2_ERROR_LOOKBEHIND_INVALID_BACKSLASH_C = 136
  PCRE2_ERROR_UNSUPPORTED_ESCAPE_SEQUENCE    = 137
  PCRE2_ERROR_CALLOUT_NUMBER_TOO_BIG         = 138
  PCRE2_ERROR_MISSING_CALLOUT_CLOSING        = 139
  PCRE2_ERROR_ESCAPE_INVALID_IN_VERB         = 140
  PCRE2_ERROR_UNRECOGNIZED_AFTER_QUERY_P     = 141
  PCRE2_ERROR_MISSING_NAME_TERMINATOR        = 142
  PCRE2_ERROR_DUPLICATE_SUBPATTERN_NAME      = 143
  PCRE2_ERROR_INVALID_SUBPATTERN_NAME        = 144
  PCRE2_ERROR_UNICODE_PROPERTIES_UNAVAILABLE = 145
  PCRE2_ERROR_MALFORMED_UNICODE_PROPERTY     = 146
  PCRE2_ERROR_UNKNOWN_UNICODE_PROPERTY       = 147
  PCRE2_ERROR_SUBPATTERN_NAME_TOO_LONG       = 148
  PCRE2_ERROR_TOO_MANY_NAMED_SUBPATTERNS     = 149
  PCRE2_ERROR_CLASS_INVALID_RANGE            = 150
  PCRE2_ERROR_OCTAL_BYTE_TOO_BIG             = 151
  PCRE2_ERROR_INTERNAL_OVERRAN_WORKSPACE     = 152
  PCRE2_ERROR_INTERNAL_MISSING_SUBPATTERN    = 153
  PCRE2_ERROR_DEFINE_TOO_MANY_BRANCHES       = 154
  PCRE2_ERROR_BACKSLASH_O_MISSING_BRACE      = 155
  PCRE2_ERROR_INTERNAL_UNKNOWN_NEWLINE       = 156
  PCRE2_ERROR_BACKSLASH_G_SYNTAX             = 157
  PCRE2_ERROR_PARENS_QUERY_R_MISSING_CLOSING = 158

  # Error 159 is obsolete and should now never occur

  PCRE2_ERROR_VERB_ARGUMENT_NOT_ALLOWED      = 159
  PCRE2_ERROR_VERB_UNKNOWN                   = 160
  PCRE2_ERROR_SUBPATTERN_NUMBER_TOO_BIG      = 161
  PCRE2_ERROR_SUBPATTERN_NAME_EXPECTED       = 162
  PCRE2_ERROR_INTERNAL_PARSED_OVERFLOW       = 163
  PCRE2_ERROR_INVALID_OCTAL                  = 164
  PCRE2_ERROR_SUBPATTERN_NAMES_MISMATCH      = 165
  PCRE2_ERROR_MARK_MISSING_ARGUMENT          = 166
  PCRE2_ERROR_INVALID_HEXADECIMAL            = 167
  PCRE2_ERROR_BACKSLASH_C_SYNTAX             = 168
  PCRE2_ERROR_BACKSLASH_K_SYNTAX             = 169
  PCRE2_ERROR_INTERNAL_BAD_CODE_LOOKBEHINDS  = 170
  PCRE2_ERROR_BACKSLASH_N_IN_CLASS           = 171
  PCRE2_ERROR_CALLOUT_STRING_TOO_LONG        = 172
  PCRE2_ERROR_UNICODE_DISALLOWED_CODE_POINT  = 173
  PCRE2_ERROR_UTF_IS_DISABLED                = 174
  PCRE2_ERROR_UCP_IS_DISABLED                = 175
  PCRE2_ERROR_VERB_NAME_TOO_LONG             = 176
  PCRE2_ERROR_BACKSLASH_U_CODE_POINT_TOO_BIG = 177
  PCRE2_ERROR_MISSING_OCTAL_OR_HEX_DIGITS    = 178
  PCRE2_ERROR_VERSION_CONDITION_SYNTAX       = 179
  PCRE2_ERROR_INTERNAL_BAD_CODE_AUTO_POSSESS = 180
  PCRE2_ERROR_CALLOUT_NO_STRING_DELIMITER    = 181
  PCRE2_ERROR_CALLOUT_BAD_STRING_DELIMITER   = 182
  PCRE2_ERROR_BACKSLASH_C_CALLER_DISABLED    = 183
  PCRE2_ERROR_QUERY_BARJX_NEST_TOO_DEEP      = 184
  PCRE2_ERROR_BACKSLASH_C_LIBRARY_DISABLED   = 185
  PCRE2_ERROR_PATTERN_TOO_COMPLICATED        = 186
  PCRE2_ERROR_LOOKBEHIND_TOO_LONG            = 187
  PCRE2_ERROR_PATTERN_STRING_TOO_LONG        = 188
  PCRE2_ERROR_INTERNAL_BAD_CODE              = 189
  PCRE2_ERROR_INTERNAL_BAD_CODE_IN_SKIP      = 190
  PCRE2_ERROR_NO_SURROGATES_IN_UTF16         = 191
  PCRE2_ERROR_BAD_LITERAL_OPTIONS            = 192
  PCRE2_ERROR_SUPPORTED_ONLY_IN_UNICODE      = 193
  PCRE2_ERROR_INVALID_HYPHEN_IN_OPTIONS      = 194
  PCRE2_ERROR_ALPHA_ASSERTION_UNKNOWN        = 195
  PCRE2_ERROR_SCRIPT_RUN_NOT_AVAILABLE       = 196

  # "Expected" matching error codes: no match and partial match.

  PCRE2_ERROR_NOMATCH                        = (-1)
  PCRE2_ERROR_PARTIAL                        = (-2)

  # Error codes for UTF-8 validity checks

  PCRE2_ERROR_UTF8_ERR1                      = (-3)
  PCRE2_ERROR_UTF8_ERR2                      = (-4)
  PCRE2_ERROR_UTF8_ERR3                      = (-5)
  PCRE2_ERROR_UTF8_ERR4                      = (-6)
  PCRE2_ERROR_UTF8_ERR5                      = (-7)
  PCRE2_ERROR_UTF8_ERR6                      = (-8)
  PCRE2_ERROR_UTF8_ERR7                      = (-9)
  PCRE2_ERROR_UTF8_ERR8                      = (-10)
  PCRE2_ERROR_UTF8_ERR9                      = (-11)
  PCRE2_ERROR_UTF8_ERR10                     = (-12)
  PCRE2_ERROR_UTF8_ERR11                     = (-13)
  PCRE2_ERROR_UTF8_ERR12                     = (-14)
  PCRE2_ERROR_UTF8_ERR13                     = (-15)
  PCRE2_ERROR_UTF8_ERR14                     = (-16)
  PCRE2_ERROR_UTF8_ERR15                     = (-17)
  PCRE2_ERROR_UTF8_ERR16                     = (-18)
  PCRE2_ERROR_UTF8_ERR17                     = (-19)
  PCRE2_ERROR_UTF8_ERR18                     = (-20)
  PCRE2_ERROR_UTF8_ERR19                     = (-21)
  PCRE2_ERROR_UTF8_ERR20                     = (-22)
  PCRE2_ERROR_UTF8_ERR21                     = (-23)

  # Error codes for UTF-16 validity checks

  PCRE2_ERROR_UTF16_ERR1                     = (-24)
  PCRE2_ERROR_UTF16_ERR2                     = (-25)
  PCRE2_ERROR_UTF16_ERR3                     = (-26)

  # Error codes for UTF-32 validity checks

  PCRE2_ERROR_UTF32_ERR1                     = (-27)
  PCRE2_ERROR_UTF32_ERR2                     = (-28)

  # Miscellaneous error codes for pcre2[_dfa]_match(), substring extraction
  # functions, context functions, and serializing functions. They are in numerical
  # order. Originally they were in alphabetical order too, but now that PCRE2 is
  # released, the numbers must not be changed.

  PCRE2_ERROR_BADDATA                        = (-29)
  PCRE2_ERROR_MIXEDTABLES                    = (-30)  # Name was changed
  PCRE2_ERROR_BADMAGIC                       = (-31)
  PCRE2_ERROR_BADMODE                        = (-32)
  PCRE2_ERROR_BADOFFSET                      = (-33)
  PCRE2_ERROR_BADOPTION                      = (-34)
  PCRE2_ERROR_BADREPLACEMENT                 = (-35)
  PCRE2_ERROR_BADUTFOFFSET                   = (-36)
  PCRE2_ERROR_CALLOUT                        = (-37)  # Never used by PCRE2 itself
  PCRE2_ERROR_DFA_BADRESTART                 = (-38)
  PCRE2_ERROR_DFA_RECURSE                    = (-39)
  PCRE2_ERROR_DFA_UCOND                      = (-40)
  PCRE2_ERROR_DFA_UFUNC                      = (-41)
  PCRE2_ERROR_DFA_UITEM                      = (-42)
  PCRE2_ERROR_DFA_WSSIZE                     = (-43)
  PCRE2_ERROR_INTERNAL                       = (-44)
  PCRE2_ERROR_JIT_BADOPTION                  = (-45)
  PCRE2_ERROR_JIT_STACKLIMIT                 = (-46)
  PCRE2_ERROR_MATCHLIMIT                     = (-47)
  PCRE2_ERROR_NOMEMORY                       = (-48)
  PCRE2_ERROR_NOSUBSTRING                    = (-49)
  PCRE2_ERROR_NOUNIQUESUBSTRING              = (-50)
  PCRE2_ERROR_NULL                           = (-51)
  PCRE2_ERROR_RECURSELOOP                    = (-52)
  PCRE2_ERROR_DEPTHLIMIT                     = (-53)
  PCRE2_ERROR_RECURSIONLIMIT                 = (-53)  # Obsolete synonym
  PCRE2_ERROR_UNAVAILABLE                    = (-54)
  PCRE2_ERROR_UNSET                          = (-55)
  PCRE2_ERROR_BADOFFSETLIMIT                 = (-56)
  PCRE2_ERROR_BADREPESCAPE                   = (-57)
  PCRE2_ERROR_REPMISSINGBRACE                = (-58)
  PCRE2_ERROR_BADSUBSTITUTION                = (-59)
  PCRE2_ERROR_BADSUBSPATTERN                 = (-60)
  PCRE2_ERROR_TOOMANYREPLACE                 = (-61)
  PCRE2_ERROR_BADSERIALIZEDDATA              = (-62)
  PCRE2_ERROR_HEAPLIMIT                      = (-63)
  PCRE2_ERROR_CONVERT_SYNTAX                 = (-64)
  PCRE2_ERROR_INTERNAL_DUPMATCH              = (-65)

  # Request types for pcre2_pattern_info()

  PCRE2_INFO_ALLOPTIONS                      = 0
  PCRE2_INFO_ARGOPTIONS                      = 1
  PCRE2_INFO_BACKREFMAX                      = 2
  PCRE2_INFO_BSR                             = 3
  PCRE2_INFO_CAPTURECOUNT                    = 4
  PCRE2_INFO_FIRSTCODEUNIT                   = 5
  PCRE2_INFO_FIRSTCODETYPE                   = 6
  PCRE2_INFO_FIRSTBITMAP                     = 7
  PCRE2_INFO_HASCRORLF                       = 8
  PCRE2_INFO_JCHANGED                        = 9
  PCRE2_INFO_JITSIZE                         = 10
  PCRE2_INFO_LASTCODEUNIT                    = 11
  PCRE2_INFO_LASTCODETYPE                    = 12
  PCRE2_INFO_MATCHEMPTY                      = 13
  PCRE2_INFO_MATCHLIMIT                      = 14
  PCRE2_INFO_MAXLOOKBEHIND                   = 15
  PCRE2_INFO_MINLENGTH                       = 16
  PCRE2_INFO_NAMECOUNT                       = 17
  PCRE2_INFO_NAMEENTRYSIZE                   = 18
  PCRE2_INFO_NAMETABLE                       = 19
  PCRE2_INFO_NEWLINE                         = 20
  PCRE2_INFO_DEPTHLIMIT                      = 21
  PCRE2_INFO_RECURSIONLIMIT                  = 21  # Obsolete synonym
  PCRE2_INFO_SIZE                            = 22
  PCRE2_INFO_HASBACKSLASHC                   = 23
  PCRE2_INFO_FRAMESIZE                       = 24
  PCRE2_INFO_HEAPLIMIT                       = 25
  PCRE2_INFO_EXTRAOPTIONS                    = 26

  # Request types for pcre2_config().

  PCRE2_CONFIG_BSR                           = 0
  PCRE2_CONFIG_JIT                           = 1
  PCRE2_CONFIG_JITTARGET                     = 2
  PCRE2_CONFIG_LINKSIZE                      = 3
  PCRE2_CONFIG_MATCHLIMIT                    = 4
  PCRE2_CONFIG_NEWLINE                       = 5
  PCRE2_CONFIG_PARENSLIMIT                   = 6
  PCRE2_CONFIG_DEPTHLIMIT                    = 7
  PCRE2_CONFIG_RECURSIONLIMIT                = 7  # Obsolete synonym
  PCRE2_CONFIG_STACKRECURSE                  = 8  # Obsolete
  PCRE2_CONFIG_UNICODE                       = 9
  PCRE2_CONFIG_UNICODE_VERSION               = 10
  PCRE2_CONFIG_VERSION                       = 11
  PCRE2_CONFIG_HEAPLIMIT                     = 12
  PCRE2_CONFIG_NEVER_BACKSLASH_C             = 13
  PCRE2_CONFIG_COMPILED_WIDTHS               = 14
end
