RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
      trace_instruction: false
}

class Array

  def merge_sort(&predicate)
    raise 'Block required' unless predicate
    return self.dup if size <= 1

    halves = split.map{ |half| half.merge_sort &predicate }
    merge *halves, &predicate
  end

  def quick_sort
    return self.dup if size <= 1
    qsort self
  end

protected

RubyVM::InstructionSequence.new(<<-EOF).eval
  def split_rec(list1, list2, result)
    return [result, list2] if list1.size <= 1
    split_rec(list1[2..-1], list2[1..-1], result + [list2.first])
  end
EOF

  def split
    split_rec self, self, []
  end

RubyVM::InstructionSequence.new(<<-EOF).eval
  def merge(list1, list2, &predicate)
    return list2.dup if list1.empty?
    return list1.dup if list2.empty?
    
    if predicate.call(list1.first, list2.first)
      [list1.first] + merge(list1[1..-1], list2, &predicate)
    else
      [list2.first] + merge(list1, list2[1..-1], &predicate)
    end
  end
EOF

# RubyVM::InstructionSequence.new(<<-EOF).eval
#   def qsort(list, &predicate)
#    return [] if list.size.zero?
#    val, *remaining = *self
#    less, more = remaining.partition { |y| y < val }
#    qsort(less, &predicate) + [val] + qsort(more, &predicate)
#   end
# EOF

RubyVM::InstructionSequence.new(<<-EOF).eval
  def qsort(list)
    pivot = list.pop
    return [] unless pivot
    qsort(list.select{ |e| e <= pivot }) + [pivot] + qsort(list.select{ |i| i > pivot })
  end
EOF

end
