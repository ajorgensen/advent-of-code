#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input = File.read(file_path)

positions = input.split("\n").first.split(",").map(&:to_i)

max = positions.max
min = positions.min

possible_positions = (min..max).to_a

cheapest_fuel = 0
cheapest_pos = nil
possible_positions.each do |pos_pos|

  fuel = positions.map do |p| 
    steps = (p-pos_pos).abs
    steps*(steps+1)/2
  end.sum

  if cheapest_pos.nil? || fuel < cheapest_fuel
    cheapest_pos = pos_pos
    cheapest_fuel = fuel
  end
end

puts "Answer: Position #{cheapest_pos} costing #{cheapest_fuel}"


