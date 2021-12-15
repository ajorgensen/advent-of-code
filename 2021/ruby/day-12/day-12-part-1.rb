#!/usr/bin/env ruby

file_path = File.expand_path("../input.txt", __FILE__)
input = File.read(file_path)

nodes = {}
edges = input.split("\n").map { |e| e.split("-") }

edges.each do |a,b|
  if a == "start"
    nodes["start"] ||= []
    nodes["start"] << b
  elsif b == "end"
    nodes[a] ||= []
    nodes[a] << b
  else
    nodes[a] ||= []
    nodes[b] ||= []
    nodes[a] << b
    nodes[b] << a
  end
end

todo = [["start"]]
paths = []

while !todo.empty?
  cur = todo.pop

  if cur.last == "end"
    paths << cur
    next
  end

  edges = nodes[cur.last]
  edges.each do |edge|
    if edge.downcase == edge && cur.include?(edge)
      next
    end

    todo << cur + [edge]
  end
end

pp nodes
puts ""
paths.each { |p| puts p.join(",") }
puts "Count: #{paths.count}"
