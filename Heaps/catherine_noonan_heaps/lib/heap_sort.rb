require_relative "heap"

class Array
  def heap_sort!
    # doesn't work - 
    # 2.upto(count).each do |group|
    #   BinaryMinHeap.heapify_up(self, group - 1, group)
    # end
    # count.downto(2).each do |group|
    #   self[group - 1], self[0] = self[0], self[group - 1]
    #   BinaryMinHeap.heapify_down(self, 0, group - 1)
    # end
  end
end




