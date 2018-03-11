def in_order_traversal(tree_node = @root, arr = [])
  # left children, itself, right children
  if tree_node.left
    in_order_traversal(tree_node.left, arr)
  end

  arr.push(tree_node.value)

  if tree_node.right
    in_order_traversal(tree_node.right, arr)
  end

  arr
end

def preorder_traversal(tree_node = @root, arr= [])
  arr.push(tree_node.value)

  preorder_traversal(tree_node.left, arr) if tree_node.left
  preorder_traversal(tree_node.right, arr) if tree_node.right

  arr
end

def postorder_traversal(tree_node = @root, arr = [])
  preorder_traversal(tree_node.left, arr) if tree_node.left
  preorder_traversal(tree_node.right, arr) if tree_node.right

  arr.push(tree_node.value)

  arr
end
