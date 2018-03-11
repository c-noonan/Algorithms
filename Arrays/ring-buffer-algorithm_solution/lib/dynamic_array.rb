require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= @capacity || @store[index] == nil
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise 'index out of bounds' if index >= @capacity
    @length += 1 if @store[index] == nil
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @store[@length-1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0

    return_value = @store[0]

    i = 0
    while i < @length
      if i > 0
        @store[i-1] = @store[i]
        @store[i] = nil if i == @length - 1
      end
      i += 1
    end
    @length -= 1

    return_value
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length += 1

    to_move = val
    i = 0
    while i < @length
      moving = to_move
      to_move = @store[i]
      @store[i] = moving
      i += 1
    end
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2

    new_arr = StaticArray.new(@capacity)
    i = 0
    while i < @length
      new_arr[i] = @store[i]
      i += 1
    end
    @store = new_arr
  end
end
