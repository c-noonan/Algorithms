require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if @length < (index + 1)
      raise "index out of bounds"
    else
      @store[(@start_idx + index) % capacity]
    end
  end

  # O(1)
  def []=(index, val)
    @store[(@start_idx + index) % capacity] = val
    @length += 1
  end

  # O(1)
  def pop
    unless @store[@start_idx]
      raise "index out of bounds"
    end
    popped = @store[(@length - 1 + @start_idx) % capacity]
    @store[(@length - 1 + @start_idx) % capacity] = nil
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(@start_idx + @length) % capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    unless @store[@start_idx]
      raise "index out of bounds"
    end
    shifted = store[start_idx]
    @store[@start_idx] = nil
    @start_idx += 1
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx -= 1
    @store[start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    dup_store = StaticArray.new(@capacity * 2)
    @capacity.times do |i|
      dup_store[i] = @store[(start_idx + i) % capacity]
    end
   @start_idx = 0
   @capacity *= 2
   @store = dup_store
  end
end

# test = RingBuffer.new
#   test.push("hi1")
#   test.push("hi2")
#   test.push("hi3")
#   test.unshift("hi4")
# p test
# p test[0]
