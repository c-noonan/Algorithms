require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  bst = BinarySearchTree.new
  bst.root = tree_node
  array = bst.in_order_traversal
  return bst.find(array[array.length - k])
end
