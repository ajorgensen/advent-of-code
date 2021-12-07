#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input = File.read(file_path)

# After one day, its internal timer would become 2.
# After another day, its internal timer would become 1.
# After another day, its internal timer would become 0.
# After another day, its internal timer would reset to 6, and it would create a new lanternfish with an internal timer of 8.
# After another day, the first lanternfish would have an internal timer of 5, and the second lanternfish would have an internal timer of 7.

fish = input.split("\n").first.split(",").map(&:to_i)

80.times do |i|
  fish = fish.map do |days_left|
    if days_left == 0
      fish << 9
      6
    else
      days_left - 1
    end
  end
end

puts "Answer: #{fish.count}"
