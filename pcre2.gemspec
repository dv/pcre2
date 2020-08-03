require_relative 'lib/pcre2/version'

Gem::Specification.new do |spec|
  spec.name          = "pcre2"
  spec.version       = Pcre2::VERSION
  spec.authors       = ["David Verhasselt"]
  spec.email         = ["david@crowdway.com"]

  spec.summary       = %q{Use the PCRE2 library inside your Ruby projects}
  spec.description   = %q{Wraps the PCRE2 library using FFI so it and the advanced functionality it provides can be used in Ruby projects}
  spec.homepage      = "https://github.com/dv/pcre2"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
