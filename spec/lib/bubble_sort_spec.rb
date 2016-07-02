require 'spec_helper'
require 'bubble_sort'

describe 'Bubble Sort' do

  it "should sort a list" do
    bubble_sort([4, 3, 78, 2, 0, 2]).should eq [0, 2, 2, 3, 4, 78]
  end
end

describe "Bubble Sort By" do
  it "should sort a list with block" do
    bubble_sort_by([4, 3, 78, 2, 0, 2]) { |l, r| l <=> r }.should eq [0, 2, 2, 3, 4, 78]
  end

  it "should be versatile enough to work with text and custom blocks" do
    bubble_sort_by(['hi', 'hello', 'hey']) { |l, r| l.length - r.length }.should eq ['hi', 'hey', 'hello']
  end
end


describe "Bubble Sort Pass" do
  it "should shift the largest number to the right" do
    bubble_sort_pass([4, 3]) { |l, r| l <=> r }.should eq [3, 4]
  end

  it "should sort 3 numbers" do
    bubble_sort_pass([4, 2, 3]) { |l, r| l <=> r }.should eq [2, 3, 4]
  end

  it "should larger numbers to the right by one" do
    bubble_sort_pass([4, 3, 78, 2, 0, 2]) { |l, r| l <=> r }.should eq [3, 4, 2, 0, 2, 78]

  end
end