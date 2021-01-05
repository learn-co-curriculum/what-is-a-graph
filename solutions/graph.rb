require 'set'

class Graph
  attr_reader :graph

  def initialize(paths)
    @graph = paths.reduce({}) { |graph, path| self.class.populate(graph, path) }
  end

  def is_adjacent(vertex_a, vertex_b)
    @graph[vertex_a].include?(vertex_b)
  end

  def add_vertex(vertex, array)
    @graph[vertex] = Set.new(array)
    array.each { |path_vertex| @graph[path_vertex].add(vertex) }
  end

  def self.populate(graph, path)
    path.each_with_index.reduce(graph) do |graph, (vertex, idx)|
      graph[vertex] = Set.new if graph[vertex].nil?
      next_vertex = path[idx + 1]

      return graph if next_vertex.nil?

      graph[vertex].add(next_vertex)
      graph[next_vertex] = Set.new if graph[next_vertex].nil? 
      graph[next_vertex].add(vertex)
      graph
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  graph = Graph.new([])

  puts "Expecting: {}"
  puts graph.graph

  puts

  graph = Graph.new([["a", "b", "c"], ["b", "d"]])

  puts 'Expecting: { a: { "b" }, b: { "a", "c", "d" }, c: { "b" }, d: { "b" }}'
  puts graph.graph

  puts

  # Don't forget to add your own!

  puts "Expecting: true"
  puts graph.is_adjacent("a", "b")

  puts

  puts "Expecting: false"
  puts graph.is_adjacent("a", "c")

  puts

  graph.add_vertex("e", ["a", "d"])
  puts 'Expecting: { a: { "b", "e" }, b: { "a", "c", "d" }, c: { "b" }, d: { "b", "e" }, e: { "a", "d" } }'
  puts graph.graph
end

# Please add your pseudocode to this file
# And a written explanation of your solution
