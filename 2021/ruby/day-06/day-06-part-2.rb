#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input = File.read(file_path)

# After one day, its internal timer would become 2.
# After another day, its internal timer would become 1.
# After another day, its internal timer would become 0.
# After another day, its internal timer would reset to 6, and it would create a new lanternfish with an internal timer of 8.
# After another day, the first lanternfish would have an internal timer of 5, and the second lanternfish would have an internal timer of 7.

fish = input.split("\n").first.split(",").map(&:to_i)

fish_states = [0,0,0,0,0,0,0,0,0]
fish.each do |fish|
  fish_states[fish] += 1
end

puts "Initial Fish: #{fish.sort.join(",")}"
puts "Initial State: #{fish_states.join(",")}"
256.times do |i|
  ready_to_reproduce = fish_states.shift
  new_fish = ready_to_reproduce

  fish_states[6] += ready_to_reproduce
  fish_states[8] = new_fish

  puts "Day #{i+1}: #{fish_states.join(",")}"
end

puts "Answer: #{fish_states.sum}"
