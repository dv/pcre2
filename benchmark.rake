require "benchmark"
require "pcre2"

desc "Run a benchmark to compare PCRE2 vs Ruby's built-in Regexp"
task :benchmark do
  def benchmark!(pattern, string)
    task = ->(re) {
      pos = 0

      while matchdata = re.match(string, pos)
        pos = matchdata.offset(0)[1] + 1
      end
    }

    GC.disable
    Benchmark.bmbm do |benchmark|
      benchmark.report("Ruby Regexp") do
        re = Regexp.new(pattern)
        100000.times { task.call(re) }
      end

      benchmark.report("PCRE2 Regexp") do
        re = PCRE2::Regexp.new(pattern)
        100000.times { task.call(re) }
      end
    end
    GC.enable

    puts
    puts
    puts
  end

  puts "Benchmark 1: Small pattern, big string"
  puts

  pattern = "hello"
  string = "abab" * 1000
  string += "hello"
  string += "abab" * 1000

  benchmark!(pattern, string)


  puts "Benchmark 2: Big pattern, big string"
  puts

  pattern = "hello" * 50
  string = "abab" * 1000
  string += "hello"
  string += "abab" * 1000
  string += pattern
  string += "abab" * 1000

  benchmark!(pattern, string)


  puts "Benchmark 3: Small pattern, small string"
  puts

  pattern = "hello"
  string = "abababab" + "hello" + "abababab"

  benchmark!(pattern, string)


  puts "Benchmark 3: Multiple matches"
  puts

  pattern = "hello"
  string = ""

  20.times do
    string += "abab" * 5
    string += "hello"
    string += "abab" * 5
  end

  benchmark!(pattern, string)
end
