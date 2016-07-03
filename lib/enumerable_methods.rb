module Enumerable
  def my_each
    enum = Enumerator.new do |y|
      for value in self
        y << block_given? ? yield(value) : value
      end
    end

    block_given? ? enum.to_a : enum
  end

  def my_each_with_index
    i = 0
    enum = Enumerator.new do |y|
      self.my_each do |value|
        y << block_given? ? yield(value, i) : [value, i]
        i += 1
      end
    end

    block_given? ? enum.to_a : enum
  end

  def my_select
    enum = Enumerator.new do |y|
      self.my_each { |item| y << item if yield item }
    end

    block_given? ? enum.to_a : enum
  end

  def my_all?
    self.my_each { |value| return false unless block_given? ? yield(value) : value }

    true
  end

  def my_any?
    self.my_each { |value| return true if block_given? ? yield(value) : value }

    false
  end

  def my_none?
    self.my_each { |value| return false if block_given? ? yield(value) : value }

    true
  end

  def my_count *match
    count = 0
    use_match, match = match.length == 1, match[0]
    self.my_each do |value|
      next if block_given? and not yield(value)
      next if use_match and match != value
      count += 1
    end
    count
  end

  def my_map
    enum = Enumerator.new do |y|
      self.my_each { |value| y << yield(value) }
    end
    block_given? ? enum.to_a : enum
  end

  def my_inject *args
    has_initial = false
    has_symbol = false
    initial = nil
    symbol = nil

    if args.length == 2
      initial, symbol = args
      has_initial = true
      has_symbol = true
    elsif args.length == 1
      if block_given?
        initial = args[0]
        has_initial = true
      else
        symbol = args[0]
        has_symbol = true
      end
    elsif args.length != 0
      # raise error
    end

    left = nil
    self.my_each_with_index do |right, i|
      if i == 0
        if has_initial
          left = initial
        else
          left = right
          next
        end
      end

      left = yield(left, right) if block_given?
      left = left.send(symbol, right) if has_symbol
    end
    left
  end
end