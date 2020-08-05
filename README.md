# PCRE2

This library provides a Ruby interface for the PCRE2 library, which supports more advanced regular expression functionality than the built-in Ruby `Regexp`.

## Installation

Install the PCRE2 library:

```bash
brew install pcre2
```

Add this line to your application's Gemfile:

```ruby
gem 'pcre2'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pcre2

## Usage

`PCRE2::Regexp` aims to act as much like Ruby's `Regexp` as possible. It has implemented a subset of the `Regexp` and `MatchData` APIs so it can be used as a drop-in replacement.

```ruby
regexp = PCRE2::Regexp.new("hello")
subject = "well hello there!"
matchdata = regexp.match(subject)

matchdata.offset(0) # [5, 10] - start and end of the match
matchdata[0] # => "hello"

matchdata = regexp.match(subject, 11) # find next match
```

## Benchmark

You can run the benchmark that compares `PCRE2::Regexp` with Ruby's built-in `Regexp` as follows:

```bash
bundle exec rake benchmark
```

## Resources

- [PCRE2 Library](https://www.pcre.org/current/doc/html/)
- [PCRE2 demo](https://www.pcre.org/current/doc/html/pcre2demo.html)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dv/pcre2.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
