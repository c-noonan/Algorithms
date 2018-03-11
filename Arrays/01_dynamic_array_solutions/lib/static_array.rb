# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    self.store[index]
  end

  # O(1)
  def []=(index, value)
    self.store[index] = value
  end

  protected
  attr_accessor :store
end

# static_arr = StaticArray.new(3)
# p static_arr
# p static_arr[2]
# static_arr[2] = "hello"
# p static_arr[2]
