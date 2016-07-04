module Enumerable
  def my_each
    return enum_for :my_each unless block_given?

    for value in self
      yield value
    end
  end

  def my_each_with_index
    return enum_for :my_each_with_index unless block_given?

    self.my_each.zip(0..Float::INFINITY) { |value, i| yield value, i }
  end

  def my_select
    return enum_for :my_select unless block_given?

    Enumerator.new { |y| self.my_each { |item| y << item if yield item } }.to_a
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

  def my_count(*match)
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
    return enum_for :my_map unless block_given?

    Enumerator.new { |y| self.my_each { |value| y << yield(value) } }.to_a
  end

  def my_inject(initial=nil, sym=nil)
    # swap arguments if not block depending on symbol
    (initial, sym = sym, initial) if not block_given? and sym === nil

    enum = self.my_each # create enumerator
    left = initial || enum.next # use initial or next

    loop { left = block_given? ? yield(left, enum.next) : left.send(sym, enum.next) }
    left
  end
end