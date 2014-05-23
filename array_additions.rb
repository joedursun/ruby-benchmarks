require 'benchmark'

Benchmark.bm do |bm|
  # pop the array to reduce memory footprint

  puts 'concat'
  conc = []
  bm.report do
    1_000_000.times do
      conc.concat([:asdf])
      conc.pop
    end
  end

  puts '<<'
  shovel = []
  bm.report do
    1_000_000.times do
      shovel << :asdf
      shovel.pop
    end
  end

  puts 'push'
  push = []
  bm.report do
    1_000_000.times do
      push.push :asdf
      push.pop
    end
  end

  puts '[]'
  arr = []
  bm.report do
    1_000_000.times do
      arr[0] = :asdf
      arr.pop
    end
  end

  puts '+='
  plus_eq = []
  bm.report do
    1_000_000.times do
      plus_eq += [:asdf]
      plus_eq.pop
    end
  end
end

#*************** Using a symbol *****************#
#         user     system      total        real
#  concat
#     0.210000   0.000000   0.210000 (  0.216235)
#  <<
#     0.110000   0.000000   0.110000 (  0.112331)
#  push
#     0.160000   0.000000   0.160000 (  0.159760)
#  []
#     0.120000   0.000000   0.120000 (  0.115884)
#  +=
#     0.210000   0.000000   0.210000 (  0.210372)

#***** Using strings not stored in a variable ****#
#***** Significant overhead in creating strings **#
#         user     system      total        real
#  concat
#     0.310000   0.000000   0.310000 (  0.304291)
#  <<
#     0.200000   0.000000   0.200000 (  0.198291)
#  push
#     0.230000   0.000000   0.230000 (  0.234561)
#  []
#     0.190000   0.000000   0.190000 (  0.192235)
#  +=
#     0.300000   0.000000   0.300000 (  0.298452)
