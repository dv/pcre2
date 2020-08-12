# PCRE2

This library provides a Ruby interface for the PCRE2 library, which supports more advanced regular expression functionality than the built-in Ruby `Regexp`.

## Why?

Ruby's `Regexp` is actually quite fast! For simple Regexps without backtracking (for instance regexp without matches like `.*`), you should probably keep using the Ruby `Regexp`. No extra dependencies and it'll be faster than using an external library, including PCRE2.

The main reason I built this was so I could use the [backtracking control verbs](https://www.rexegg.com/backtracking-control-verbs.html#mainverbs) such as `(*SKIP)(*FAIL)` that are not supported by Ruby's `Regexp`. Using these, and other features, `PCRE2` supports some pretty wild and advanced regular expressions which you cannot do with Ruby's `Regexp`.

`PCRE2` also supports JIT (just-in-time) compilation of the regular expression. From [the manual](https://www.pcre.org/current/doc/html/pcre2jit.html):
> Just-in-time compiling is a heavyweight optimization that can greatly speed up pattern matching. However, it comes at the cost of extra processing before the match is performed, so it is of most benefit when the same pattern is going to be matched many times. This does not necessarily mean many calls of a matching function; if the pattern is not anchored, matching attempts may take place many times at various positions in the subject, even for a single call. Therefore, if the subject string is very long, it may still pay to use JIT even for one-off matches.

You can enable JIT by calling `regexp.jit!` on the `PCRE2::Regexp` object. Using JIT the `PCRE2` matching can be more than 2X faster than Ruby's built-in.

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

Also some of the utility methods on `String` are reimplemented on `PCRE2::Regexp`:

```ruby
regexp = PCRE2::Regexp.new('\d+')
subject = "and a 1 and a 2 and a 345"

regexp.scan(subject) # => ["1", "2", "345"]
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
