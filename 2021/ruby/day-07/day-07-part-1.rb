#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input = File.read(file_path)

positions = input.split("\n").first.split(",").map(&:to_i)
#positions = [16,1,2,0,4,2,7,1,2,14]

possible_positions = positions.uniq.sort

cheapest_fuel = 0
cheapest_pos = nil
possible_positions.each do |pos_pos|
  fuel = positions.map { |p| (p-pos_pos).abs }.sum

  if cheapest_pos.nil? || fuel < cheapest_fuel
    cheapest_pos = pos_pos
    cheapest_fuel = fuel
  end
end

puts "Answer: Position #{cheapest_pos} costing #{cheapest_fuel}"
