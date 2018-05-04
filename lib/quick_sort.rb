class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    mid = array[array.length / 2]
    left = sort1(array.select { |e| mid > e })
    right = sort1(array.select { |e| mid < e })
    left + [mid] + right
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2

    mid = partition(array, start, length, &prc)
    left = mid - start
    right = length - left - 1

    sort2!(array, start, left, &prc)
    sort2!(array, mid + 1, right, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= proc { |el1, el2| el1 <=> el2 }
    # pivot_idx = start + rand(length)
    # array[start], array[pivot_idx] = array[pivot_idx], array[start]

    pivot = array[start]

    delim = start + 1
    idx = delim
    while idx < start + length
      if prc.call(pivot, array[idx]) >= 0
        array[delim], array[idx] = array[idx], array[delim]
        delim += 1
      end
      idx += 1
    end
    array[start], array[delim - 1] = array[delim - 1], array[start]
    pivot_idx = delim - 1
  end
end
