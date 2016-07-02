def bubble_sort list
  bubble_sort_by(list) { |l, r| l <=> r }
end

def bubble_sort_by list
  list.length.times { list = bubble_sort_pass(list) { |l, r| yield(l, r) } }
  list
end

def bubble_sort_pass list
  passed = []

  left = list.shift
  while list.length >= 1
    right = list.shift

    if yield(left, right) > 0
      left, right = right, left
    end

    passed.push left
    left = right
  end
  passed.push left

  passed
end