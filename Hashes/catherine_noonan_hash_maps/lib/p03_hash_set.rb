require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    @count += 1
    resize! if @count == num_buckets
    @store[num % num_buckets].push(num)
  end

  def include?(key)
    num = key.hash
    @store[num % num_buckets].include?(num)
  end

  def remove(key)
    num = key.hash
    @count -= 1
    @store[num % num_buckets].delete(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old = @store
    @store = Array.new(num_buckets*2) {Array.new}
    @count = 0
    old.flatten.each do |i|
      insert(i)
    end
  end
end

