require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []
  vertices.each do |vertex|
    if vertex.in_edges.empty?
        queue.push(vertex)
    end 
  end
  until queue.empty?
    vertice = queue.shift
    sorted.push(vertice)
    until vertice.out_edges.empty?
      edge = vertice.out_edges[0]
      to_vertex = edge.to_vertex
      edge.destroy!
      if to_vertex.in_edges.empty?
        queue.push(to_vertex)
      end
    end
  end
  return [] if sorted.length < vertices.length
  sorted
end


