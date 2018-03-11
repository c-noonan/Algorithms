require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    if self.length < (index + 1)
      raise "index out of bounds"
    else
      self.store[index]
    end
  end

  # O(1)
  def []=(index, value)
    store[index] = value
  end

  # O(1)
  def pop
    if (self.length == 0)
      raise "index out of bounds"
    end
    store[@length] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      self.resize!
    end
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if (self.length == 0)
      raise "index out of bounds"
    end
    dup_store = StaticArray.new(@length - 1)
    idx = 1
    while idx < @length
      dup_store[idx - 1] = @store[idx]
      idx += 1
    end
    @store = dup_store
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == @capacity
      self.resize!
    end
    dup_store = StaticArray.new(@length + 1)
    dup_store[0] = val
    idx = 0
    while idx < @length
      dup_store[idx + 1] = @store[idx]
      idx += 1
    end
    @store = dup_store
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
    dup_store = StaticArray.new(@capacity)
    idx = 0
    @capacity.times do |idx|
      dup_store[idx] = @store[idx]
      idx += 1
    end
  end
end

# test = DynamicArray.new
# test.unshift("hi")
# test.unshift("hi")
# test.shift
# test.shift
