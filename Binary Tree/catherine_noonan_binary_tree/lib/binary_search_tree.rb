# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.

require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if (@root == nil)
      @root = BSTNode.new(value)
      return @root
    end
    insert_rec(@root, value)
  end
  
  def find(value, tree_node = @root)
    if ( tree_node == nil)
      return nil
    elsif (value == tree_node.value)
      return tree_node
    elsif (value > tree_node.value)
      find(value, tree_node.right)
    else
      find(value,tree_node.left)
    end
  end
  
  def delete(value)
    return @root = nil if @root.value == value
    node = find(value)
    parent = get_parent(value)
    if !node.left && !node.right
      replace_parents_child(parent, nil, value)
    elsif !node.left && node.right
      replace_parents_child(parent, node.right, value)
    elsif node.left && !node.right
      replace_parents_child(parent, node.left, value)
    elsif node.left && node.right
      max_node = maximum(node.left)
      parent_of_max = get_parent(max_node.value)
      replace_parents_child(parent, max_node, value)
      if max_node.left
        temp = max_node.left
        replace_parents_child(parent_of_max, temp, max_node.value)
      else
        temp = max_node.right
        replace_parents_child(parent_of_max, temp, max_node.value)
      end
    end
  end
  
  # helper method for #delete:
  def maximum(tree_node = @root)
    while (tree_node.right != nil)
      tree_node = tree_node.right
    end
    tree_node
  end
  
  def depth(tree_node = @root)
    if (tree_node == nil)
      return -1
    else
      return [depth(tree_node.left),depth(tree_node.right)].max + 1
    end 
  end 
  
  def is_balanced?(tree_node = @root)
    (depth(@root.left) - depth(@root.right)).abs ==  0
  end
  
  def in_order_traversal(tree_node = @root, arr = [])
    return [] if !tree_node
    left = self.in_order_traversal(tree_node.left) 
    right = self.in_order_traversal(tree_node.right)
    left + [tree_node.value] + right
  end
  
  private
  # optional helper methods go here:
  def insert_rec(node, value)
    if (value > node.value)
      !node.right ? node.right = BSTNode.new(value) : insert_rec(node.right, value)
    else
      !node.left ? node.left = BSTNode.new(value) : insert_rec(node.left, value) 
    end
  end

  def get_parent(value, parent = @root)
    return parent if parent.left.value == value || parent.right.value == value
    if value <= parent.value
      return parent.left.nil? ? nil : get_parent(value, parent.left)
    else
      return parent.right.nil? ? nil : get_parent(value, parent.right)
    end
  end
  
  def replace_parents_child(parent, item, value)
    parent.left = item if parent.left.value == value
    parent.right = item if parent.right.value == value
  end
  
end
