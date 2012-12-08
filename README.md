## rb-array-sorting

  Recursive merge sort in Ruby.
  [![endorse](http://api.coderwall.com/mtchavez/endorsecount.png)](http://coderwall.com/mtchavez)

### Merge Sort
Example:

    array = []
    7000.times{ array << rand(500) }
    array.merge_sort { |a,b| a <= b }

### Quick Sort
Example:

    array = []
    7000.times{ array << rand(500) }
    array.quick_sort

### Benchmarks

Benchmarks of merge and quick sort against ruby array sort:

    require 'benchmark'

    Benchmark.bm do |b|
      b.report('ruby')       { array.sort }
      b.report('merge_sort') { array.merge_sort { |a,b| a <= b } }
      b.report('quick_sort') { array.quick_sort }
    end

                user       system     total       real
    ruby        0.000000   0.000000   0.000000 (  0.001410)
    merge_sort  0.430000   0.020000   0.450000 (  0.451126)
    quick_sort  0.060000   0.000000   0.060000 (  0.059994)

### Specs
Run ```rake``` for specs.

