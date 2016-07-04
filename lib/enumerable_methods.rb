module Enumerable
  def my_each
    # Guard, use as enum
    return enum_for :my_each unless block_given?

    for value in self
      yield value
    end
  end

  def my_each_with_index
    # Guard, use as enum
    return enum_for :my_each_with_index unless block_given?

    self.my_each.zip(0..Float::INFINITY) { |value, i| yield value, i }
  end

  def my_select
    return enum_for :my_select unless block_given?

    Enumerator.new do |y|

      self.my_each { |item| y << item if yield item } # for each item ... keep if yield (item)
    end.to_a # return as array
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

  def my_count(item=:NONE)
    is_item = lambda { |value| item==:NONE or item==value } # match with item arg or true if arg empty
    is_match = lambda { |value| block_given? ? yield(value) : is_item.call(value) } # match with yield or item arg

    # start 0, increment if is match otherwise continue
    self.my_inject(0) { |count, value| is_match.call(value) ? count + 1 : count }
  end

  def my_map
    # Guard, use as enum
    return enum_for :my_map unless block_given?

    Enumerator.new do |y|
      self.my_each { |value| y << yield(value) } # for each item ... yield item
    end.to_a # return as array
  end

  def my_inject(initial=nil, sym=nil)
    # swap arguments if depending on missing symbol
    (initial, sym = sym, initial) if not block_given? and sym === nil

    enum = self.my_each # create enumerator
    result = initial || enum.next # use initial or next


    # for each value ... result = yield (result, next)
    loop { result = block_given? ? yield(result, enum.next) : result.send(sym, enum.next) }
    result
  end
end