require 'benchmark'

test_string = 'I pity the fool'
valid_regexes = [/(page=\d+)/, /(preview|p|foo)=/]
valid_strings = %w| page preview p foo |
JOINED = /(#{valid_strings.join('|')})=/

Benchmark.bm do |bm|
  puts "using separate matches"
  bm.report do
    1_000_000.times do
      test_string.match(/preview=/) || test_string.match(/p=/) || test_string.match(/foo=/)
    end
  end

  puts "\nusing one match"
  bm.report do
    1_000_000.times do
      test_string.match(/(preview|p|foo)=/)
    end
  end

  puts "\nusing String#[]"
  bm.report do
    1_000_000.times do
      test_string[JOINED]
    end
  end

  puts "\nusing separate '=~' operators"
  bm.report do
    1_000_000.times do
      test_string =~ /preview=/ || test_string =~ /p=/ || test_string =~ /foo=/
    end
  end

  puts "\nusing one '=~' operator"
  bm.report do
    1_000_000.times do
      test_string =~ /(preview|p|foo)=/
    end
  end

  puts "\nusing Array#any?"
  bm.report do
    1_000_000.times do
      valid_regexes.any? {|reg| test_string =~ reg}
    end
  end

  puts "\nusing Array#join"
  bm.report do
    1_000_000.times do
      test_string =~ JOINED
    end
  end
  puts "\n"
end

#         user     system      total        real
#  using separate matches
#     1.350000   0.000000   1.350000 (  1.350126)
#
#  using one match
#     0.770000   0.000000   0.770000 (  0.768811)
#
#  using String#[]
#     0.740000   0.000000   0.740000 (  0.733851)
#
#  using separate '=~' operators
#     1.010000   0.000000   1.010000 (  1.010286)
#
#  using one '=~' operator
#     0.620000   0.000000   0.620000 (  0.627791)
#
#  using Array#any?
#     1.510000   0.000000   1.510000 (  1.504694)
#
#  using Array#join
#     0.720000   0.000000   0.720000 (  0.728353)
