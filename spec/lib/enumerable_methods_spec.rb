require 'spec_helper'
require 'enumerable_methods'

describe Enumerable do

  describe '#my_each' do
    it 'should exist' do
      [].respond_to?(:my_each).should be_truthy
    end
    it 'should return run block on each item' do
      items = []
      %w(a b c).my_each { |i| items << i }
      items.should eq %w(a b c)
    end
  end

  describe '#my_each_with_index' do
    it 'should exist' do
      [].respond_to?(:my_each_with_index).should be_truthy
    end

    it 'should run block with on each item with index' do
      hash = {}
      %w(a b c).my_each_with_index { |v, i| hash[i] = v }
      hash.should eq ({ 0 => 'a', 1 => 'b', 2 => 'c' })
    end

    it 'should satisfy docs example' do
      hash = Hash.new
      %w(cat dog wombat).my_each_with_index { |item, index| hash[item] = index }

      hash.should eq ({ 'cat' => 0, 'dog' => 1, 'wombat' => 2 })
    end
  end

  describe '#my_select' do
    it 'should exist' do
      [].respond_to?(:my_select).should be_truthy
    end

    it 'should filter remove false' do
      (1..10).my_select { |i| i % 3 == 0 }.should eq [3, 6, 9]
    end

    it 'should satisfy docs example' do
      [1, 2, 3, 4, 5].my_select { |num| num.even? }.should eq [2, 4]
    end
  end

  describe '#my_all?' do
    it 'should exist' do
      [].respond_to?(:my_all?).should be true
    end

    it 'should return true if each block returns true' do
      %w[ant bear cat].my_all? { |word| word.length >= 3 }.should be true
    end

    it 'should return false if any block returns false' do
      %w[ant bear cat].my_all? { |word| word.length >= 4 }.should be false
    end

    it 'should check if each value is true with no block' do
      [nil, true, 99].my_all?.should be false
    end

    it 'should check if each value is true with no block' do
      ['', true, 99].my_all?.should be true
    end
  end

  describe '#my_any?' do
    it 'should exist' do
      [].respond_to?(:my_any?).should be true
    end

    it 'should return true if any blocks are true' do
      %w[ant bear cat].my_any? { |word| word.length >= 3 }.should be true
    end

    it 'should return true if any blocks are true' do
      %w[ant bear cat].my_any? { |word| word.length >= 4 }.should be true
    end

    it 'should return false if no blocks are true' do
      %w[ant bear cat].my_any? { |word| word.length >= 5 }.should equal false
    end

    it 'should use implicit block when no block given' do
      [nil, true, 99].my_any?.should be true
    end

    it 'should use implicit block when no block given' do
      [nil, false].my_any?.should be false
    end

  end

  describe '#my_none?' do
    it 'should exist' do
      [].respond_to?(:my_none?).should be_truthy
    end

    it 'should return true if no blocks are true' do
      %w[ant bear cat].my_none? { |word| word.length == 5 }.should be true
    end

    it 'should return false if any blocks are true' do
      %w[ant bear cat].my_none? { |word| word.length >= 4 }.should be false
    end

    it 'should return true for an empty list' do
      [].my_none?.should be true
    end

    it 'should return true if no values are true and no block defined' do
      [nil].my_none?.should be true
    end

    it 'should return true if no values are true and no block defined' do
      [nil, false].my_none?.should be true
    end

    it 'should return false if any values are true and no block defined' do
      [nil, false, true].my_none?.should be false
    end


  end

  describe '#my_count' do
    before(:each) do
      @array = [1, 2, 4, 2]
    end

    it 'should exist' do
      [].respond_to?(:my_count).should be_truthy
    end

    it 'should count each item with no arguments' do
      @array.my_count.should be 4
    end

    it 'should count matches if argument exists' do
      @array.my_count(2).should be 2
    end

    it 'should count number of blocks yielding true if block is given' do
      @array.my_count { |x| x % 2 == 0 }.should be 3
    end

    it 'should work with nil arguments' do
      @array.my_count(nil).should be 0
    end
  end

  describe '#my_map' do
    it 'should exist' do
      [].respond_to?(:my_map).should be_truthy
    end

    it 'should return a new array with the results of running a block once for each element' do
      (1..4).my_map { |i| i*i }.should eq [1, 4, 9, 16]
    end

    it 'should return a new array with the results of running a block once for each element' do
      (1..4).my_map { 'cat' }.should eq %w(cat) * 4
    end

    it 'should accept a proc' do
      proc = Proc.new { |i| i*i }

      (1..4).my_map(&proc).should eq [1, 4, 9, 16]
    end
  end

  describe '#my_inject' do
    it 'should exist' do
      [].respond_to?(:my_inject).should be_truthy
    end

    it 'should sum some number with symbol' do
      (5..10).my_inject(:+).should be 45
    end

    it 'should sum some numbers with a block' do
      (5..10).my_inject { |sum, value| sum + value }.should be 45
    end

    it 'should should multiply some numbers with initial value and symbol' do
      (5..10).my_inject(2, :*).should be 302400
    end

    it 'should should multiply some numbers with initial value and a block' do
      (5..10).my_inject(2) { |product, value| product * value }.should be 302400
    end

    it 'should find the longest word' do
      longest = %w[cat sheep bear].my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end

      longest.should eq 'sheep'
    end

    it 'should multiply elements' do
      def multiply_els(items)
        items.my_inject { |l, r| l * r }
      end

      multiply_els([2, 4, 5]).should equal 40
    end
  end

end