class Array

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|a, b| a<=>b}
    return array if length <= 1
    pivot = start
    pivot_el = array[start]
    ((start + 1)..(start + length - 1)).each do |index|
      if prc.call(pivot_el, array[index]) > 0
        array[index], array[pivot+1] = array[pivot+1], array[index]
        pivot += 1
      end
    end
    array[start], array[pivot] = array[pivot], array[start]
    pivot
  end

  def select_kth_smallest(k)
    return nil if k > self.length
    left = 0
    right = self.length - 1
    while true
      return self[left] if left == right
      pivot_el = Array.partition(self, left, (right - left + 1))
      if (k-1) == pivot_el
        return self[k-1]
      elsif k-1 < pivot_el
        right = pivot_el - 1
      else
        left = pivot_el + 1
      end
    end
  end
end

arr = [1,4,2,5,3,5,6]
p arr.select_kth_smallest(1) == 1
p arr.select_kth_smallest(2) == 2
p arr.select_kth_smallest(3) == 3
p arr.select_kth_smallest(4) == 4
p arr.select_kth_smallest(5) == 5
p arr.select_kth_smallest(6) == 5
