require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @start_idx = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    actual_idx = @start_idx + index
    actual_idx -= @capacity if actual_idx >= @capacity

    raise 'index out of bounds' if index >= @capacity || @store[actual_idx] == nil
    @store[actual_idx]
  end

  # O(1)
  def []=(index, val)
    raise 'index out of bounds' if index >= @capacity
    actual_idx = @start_idx + index
    actual_idx -= @capacity if actual_idx >= @capacity

    @length += 1 if @store[actual_idx] == nil
    @store[actual_idx] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    actual_idx = @start_idx + @length - 1
    actual_idx -= @capacity if actual_idx >= @capacity

    return_value = @store[actual_idx]
    @store[actual_idx] = nil
    @length -= 1
    return_value
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    actual_idx = @start_idx + @length
    actual_idx -= @capacity if actual_idx >= @capacity
    @length += 1
    @store[actual_idx] = val
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    return_value = @store[@start_idx]

    @store[@start_idx] = nil
    @length -= 1
    @start_idx < @capacity - 1 ? @start_idx += 1 : @start_idx = 0

    return_value
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx > 0 ? @start_idx -= 1 : @start_idx = @capacity - 1
    @length += 1
    @store[@start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    @capacity *= 2
    new_arr = StaticArray.new(@capacity)
    i = @start_idx
    count = 0

    while count < @length
      new_arr[count] = @store[i]
      i += 1
      i -= @capacity/2 if i == @capacity/2
      count += 1
    end

    @start_idx = 0
    @store = new_arr
  end
end
