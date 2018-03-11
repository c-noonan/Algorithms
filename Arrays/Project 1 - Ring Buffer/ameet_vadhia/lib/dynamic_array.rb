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
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    check_index(@length - 1)
    value = @store[@length - 1]
    @store[@length - 1] = nil
    @length = @length - 1
    value
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if(@length == @capacity)
      resize!
    end
    @store[@length] = val
    @length = @length + 1

    nil
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(@length - 1)
    first = self[0]
    (1...@length).each do |i|
      self[i-1] = self[i]
    end
    @length = @length - 1
    first
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity

    @length = @length + 1

    (@length-2).downto(0) do |i|
      self[i + 1] = self[i]
    end

    self[0] = val

    nil
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if(index < 0 || index >= @length)
      raise 'index out of bounds'
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
    array = StaticArray.new(@capacity)
    @length.times do |i|
      array[i] = @store[i]
    end
    @store = array
  end
end
