require 'benchmark'

def title(str)
  puts "\n******#{str}*****\n\n"
end

Benchmark.bm do |bm|
  title('Hash membership')
  params = {foo: :some_value, bar: :some_value, name: :some_value, city: :some_value, occupation: :some_value, address: :some_value}

  puts 'Hash#[]'
  bm.report do
    1_000_000.times do
      params[:city]
    end
  end

  puts 'Hash#has_key?'
  bm.report do
    1_000_000.times do
      params.has_key? :city
    end
  end

  puts 'Hash#key?'
  bm.report do
    1_000_000.times do
      params.key? :city
    end
  end

  puts 'Hash#member?'
  bm.report do
    1_000_000.times do
      params.member? :city
    end
  end

  puts 'Hash#include?'
  bm.report do
    1_000_000.times do
      params.include? :city
    end
  end

  puts 'Hash#fetch'
  bm.report do
    1_000_000.times do
      params.fetch :city
    end
  end

  title('Updating keys/values')

  puts 'Hash#[]='
  bm.report do
    1_000_000.times do
      params[:city] = :Atlanta
    end
  end

  puts 'Hash#merge'
  bm.report do
    1_000_000.times do
      params.merge(city: :Miami)
    end
  end

  puts 'Hash#store'
  bm.report do
    1_000_000.times do
      params.store(:city, :Seoul)
    end
  end

  title('Value lookup')

  puts 'Hash#value?'
  bm.report do
    1_000_000.times do
      params.value?(:some_value)
    end
  end

  puts 'Hash#has_value?'
  bm.report do
    1_000_000.times do
      params.has_value?(:some_value)
    end
  end

  title('Iterating')

  puts 'Hash#each'
  bm.report do
    1_000_000.times do
      params.each { |k,v| true }
    end
  end


  puts 'Hash#each_pair'
  bm.report do
    1_000_000.times do
      params.each_pair { |k,v| true }
    end
  end

  puts "\n"
end

# ******Hash membership*****

# Hash#[]
#    0.050000   0.000000   0.050000 (  0.041780)
# Hash#has_key?
#    0.040000   0.000000   0.040000 (  0.047898)
# Hash#key?
#    0.050000   0.000000   0.050000 (  0.047362)
# Hash#member?
#    0.050000   0.000000   0.050000 (  0.046999)
# Hash#include?
#    0.050000   0.000000   0.050000 (  0.046919)
# Hash#fetch
#    0.060000   0.000000   0.060000 (  0.063220)
# Hash#[]=
#    0.050000   0.000000   0.050000 (  0.052752)
# Hash#merge
#    0.810000   0.010000   0.820000 (  0.811340)
# Hash#store
#    0.060000   0.000000   0.060000 (  0.058359)
# Hash#value?
#    0.060000   0.000000   0.060000 (  0.060768)
# Hash#has_value?
#    0.060000   0.000000   0.060000 (  0.060486)
# Hash#each
#    0.310000   0.000000   0.310000 (  0.308079)
# Hash#each_pair
#    0.310000   0.000000   0.310000 (  0.307169)
