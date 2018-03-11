# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length) {nil}
    @capacity = length
    @length = 0
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index > @capacity - 1
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise 'index out of bounds' if index > @capacity - 1
    @length += 1 if @store[index] == nil
    @store[index] = value
  end

  protected
  attr_accessor :store
end
