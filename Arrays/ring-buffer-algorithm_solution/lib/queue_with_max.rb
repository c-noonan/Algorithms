# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax #added LinkedList functionality for O(1) all-around
  attr_accessor :store, :before, :after

  def initialize(before = nil)
    @store = RingBuffer.new #main store
    @before = before

    if @before
      @after = nil
      @current_node = self
    else
      @after = QueueWithMax.new(self) #store of maxes
      @current_node = @after
    end

  end

  def enqueue(val) #O(1) amortized
    @store.push(val) unless @before #not top-level: store of maxes

    if @current_node.store.length == 0 ||
       val > @current_node.store[@current_node.store.length - 1]
      @current_node.store.push(val)
    elsif @current_node.after
      @current_node.after.enqueue(val)
    else
      @current_node.after = QueueWithMax.new(@current_node)
      @current_node.after.store.push(val)
    end
  end

  def dequeue(val = nil) # always O(1)--e.g. [1,5,2,4,3]; [1,2,3,4,5]; [5,4,3,2,1]
    val = @store.shift unless @before

    if @current_node.store[0] == val
      @current_node.store.shift
    else
      @current_node.after.dequeue(val)
    end

    # if next level is empty, cuts it out of LinkedList
    @current_node.after = @current_node.after.after if @current_node.after && @current_node.after.store.length == 0
    # if current level is empty, moves down a level
    @current_node = @current_node.after if @current_node.store.length == 0

    val
  end

  def max # O(1); worst-case O(n/2), where each level has only 2 items
    @current_node = @current_node.after if @current_node.store.length == 0
    @current_node.store[@current_node.store.length - 1]
  end

  def length
    @store.length
  end

end
