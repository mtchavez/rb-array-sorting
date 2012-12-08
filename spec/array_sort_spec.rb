require 'spec_helper'

describe Array do

  let(:unsorted) { array = []; 7000.times{ array << rand(500) }; array }

  describe 'merge_sort' do

    it 'is an instance method' do
      [].must_respond_to :merge_sort
    end

    it 'expects a block' do
      assert_raises(RuntimeError, 'Block required') { unsorted.merge_sort }
    end

    it 'returns sorted array' do
      sorted = unsorted.merge_sort { |a,b| a <= b }
      unsorted.sort.must_equal sorted
      
      sorted = unsorted.merge_sort { |a,b| a >= b }
      unsorted.sort.reverse.must_equal sorted
    end

  end

  describe 'quick_sort' do

    it 'is an instace method' do
      [].must_respond_to :quick_sort
    end

    it 'returns sorted array' do
      sorted = unsorted.quick_sort
      unsorted.sort.must_equal sorted
    end

  end

end
