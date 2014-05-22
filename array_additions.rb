require 'benchmark'

Benchmark.bm do |bm|
  # pop the array to reduce memory footprint
  puts 'concat'
  conc = []
  bm.report do
    1_000_000.times do
      conc.concat(['asdf'])
      conc.pop
    end
  end

  puts '<<'
  shovel = []
  bm.report do
    1_000_000.times do
      shovel << 'asdf'
      shovel.pop
    end
  end

  puts 'push'
  push = []
  bm.report do
    1_000_000.times do
      push.push 'asdf'
      push.pop
    end
  end
end

#         user     system      total        real
#  concat
#     0.290000   0.000000   0.290000 (  0.292493)
#  <<
#     0.190000   0.000000   0.190000 (  0.184427)
#  push
#     0.220000   0.000000   0.220000 (  0.224693)
