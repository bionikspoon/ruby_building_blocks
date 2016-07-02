def stock_picker prices
  max_diff = 0
  buy = 0
  sell = 1
  (prices.length - 1).times do |i|
    left, right = prices[0..i], prices[i+1..-1]
    min, max = left.min, right.max
    diff = min - max

    if diff > max_diff
      max_diff = diff
      buy = left.index(min) + 1
      sell = right.index(max) + i + 1
    end


  end

  [buy, sell]
end