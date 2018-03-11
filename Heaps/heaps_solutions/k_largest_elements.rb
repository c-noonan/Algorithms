require_relative 'heap'

def k_largest_elements(array, k)
  result = BinaryMinHeap.new
  k.times do
    result.push(array.pop)
  end
  until array.empty?
    result.push(array.pop)
    result.extract
  end
  result.store
end
