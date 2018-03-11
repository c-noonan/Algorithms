# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_reader :enqueue_buffer, :enqueue_buffer_max_history, :dequeue_buffer, :dequeue_buffer_max_history

  def initialize
    @enqueue_buffer = RingBuffer.new
    @enqueue_buffer_max_history = RingBuffer.new

    @dequeue_buffer = RingBuffer.new
    @dequeue_buffer_max_history = RingBuffer.new
  end

  # time_complexity == O(c)
  def enqueue(val)
    @enqueue_buffer.push(val)
    # as new items are queued, we identify whether or not they are a max value
    if @enqueue_buffer_max_history.length == 0 ||
      val > @enqueue_buffer_max_history[@enqueue_buffer_max_history.length - 1]
      @enqueue_buffer_max_history.push(val)
    end
  end

  # time_complexity == O(n) -- queify helper method (places all items into another ring buffer in rev order)
  def dequeue
    # if no items are in the dequeue_buffer we add them by "queueify-ing" the enqueue_buffer (O(n))
    queueify if @dequeue_buffer.length == 0

    # remove last item in dequeue_buffer (same as removing first item in enqueue_buffer)
    popped = @dequeue_buffer.pop
    if @dequeue_buffer_max_history.length > 0 &&
       popped == @dequeue_buffer_max_history[@dequeue_buffer_max_history.length - 1]
      @dequeue_buffer_max_history.pop
    end
    popped
  end

  # amortized time_complexity == O(c)
  def max
    in_max = @enqueue_buffer_max_history[@enqueue_buffer_max_history.length - 1]
    out_max = @dequeue_buffer_max_history[@dequeue_buffer_max_history.length - 1]
    return in_max if in_max && !out_max
    return in_max if in_max && in_max > out_max
    out_max
  end

  def length
    @enqueue_buffer.length + @dequeue_buffer.length
  end

  private

  def queueify
    until @enqueue_buffer.length == 0

      # remove first item in the enqueue_buffer and push into dequeue_buffer
      popped = @enqueue_buffer.pop
      @dequeue_buffer.push(popped)

      # if removed item was a max value, remove from enqueue_buffer_max_history
      if @enqueue_buffer_max_history.length > 0 &&
         popped == @enqueue_buffer_max_history[@enqueue_buffer_max_history.length - 1]
        @enqueue_buffer_max_history.pop
      end

      # if the removed item is a max value, add item to dequeue_buffer_max_history to keep track of max value
      if @dequeue_buffer_max_history.length == 0 ||
         popped > @dequeue_buffer_max_history[@dequeue_buffer_max_history.length - 1]
        @dequeue_buffer_max_history.push(popped)
      end
    end
  end

end

# test = QueueWithMax.new
# test.enqueue(0)
# test.enqueue(1)
# test.enqueue(2)
# test.enqueue(3)
# p test
# p test.length
# p "-------------------------------------------------"
# test.dequeue
# test.dequeue
# test.enqueue(4)
# test.enqueue(5)
# test.dequeue
# test.dequeue
# test.dequeue
# p test
# p test.length
# p test.enqueue_buffer
# p test.dequeue_buffer
# p test.max
