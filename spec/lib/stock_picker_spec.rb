require 'rspec'
require 'stock_picker'

describe 'Stock Picker' do

  it 'should buy low and sell high' do
    stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10]).should eq [1, 4]
  end

  it 'should buy handle lowest price on last day' do
    stock_picker([17, 3, 6, 9, 15, 8, 6, 1]).should eq [1, 4]
  end

end