# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    self.store = Array.new(length, 0)
  end

  # O(1)
  def [](index)
    self.store[index]
  end

  # O(1)
  def []=(index, value)
    value = self.store[index]
  end

  protected
  attr_accessor :store
end
