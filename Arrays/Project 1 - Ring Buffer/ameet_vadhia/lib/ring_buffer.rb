require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= @length
    idx = (@start_idx + index) % @capacity
    @store[idx]
  end

  # O(1)
  def []=(index, val)
    raise 'index out of bounds' if index >= @length
    idx = (@start_idx + index) % @capacity
    @store[idx] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    value = self[@length - 1]
    self[@length - 1] = nil
    @length = @length - 1
    value
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length = @length + 1
    self[@length - 1] = val
    nil
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    value = self[0]
    @start_idx = (@start_idx + 1) % @capacity
    @length = @length - 1
    value
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @length = @length + 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def resize!
    # @capacity = @capacity * 2
    # array = StaticArray.new(@capacity)
    #
    # @store[0...@start_idx].each_with_index do |el, idx|
    #   array[idx] = el
    # end
    #
    # @store[@start_idx...@length].each_with_index do |el, idx|
    #   array[idx + @length + @start_idx] = el
    # end
    #
    # @start_idx = @capacity - @length + @start_idx
    #
    # @store = array

    array = StaticArray.new(@capacity * 2)
    @length.times do |i|
      array[i] = self[i]
    end
    @start_idx = 0
    @capacity = @capacity * 2
    @store = array
  end
end
