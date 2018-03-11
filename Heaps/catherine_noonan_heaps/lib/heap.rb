class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    @store = Array.new
  end

  def count
    @store.length
  end
  
  def extract
    start = store[0]
    if self.count > 1
      store[0] = store.pop
      self.class.heapify_down(store, 0, &@prc)
    else
      store.pop
    end
    start
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, self.count - 1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_one = (2*parent_index) + 1
    child_two = (2*parent_index) + 2
    [child_one, child_two].select { |idx| idx < len }
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    child_indexes = child_indices(len, parent_idx)
    child_index_one = child_indexes[0]
    child_index_two = child_indexes[-1]
    parent_val = array[parent_idx]

    child_nodes = []
    child_nodes << array[child_index_one] if child_index_one
    child_nodes << array[child_index_two] if child_index_two

    if child_nodes.all? { |child| prc.call(parent_val, child) <= 0 }
      return array
    end

    swap_index = nil
    if child_nodes.length == 1
      swap_index = child_index_one
    else
      swap_index = prc.call(child_nodes[0], child_nodes[1]) == -1 ? child_index_one : child_index_two
    end
    array[parent_idx], array[swap_index] = array[swap_index], array[parent_idx]
    heapify_down(array, swap_index, len = array.length, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if child_idx == 0
    parent_idx = parent_index(child_idx)
    child_val = array[child_idx]
    parent_val = array[parent_idx]
    if prc.call(child_val, parent_val) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      heapify_up(array, parent_idx, len = array.length, &prc)
    end
  end
end
