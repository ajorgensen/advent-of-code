#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input = File.read(file_path)

commands = input.split("\n")

horizontal = 0
depth = 0

commands.each do |cmd|
  direction, amount = cmd.split
  amount = amount.to_i

  case direction
  when "forward"
    horizontal += amount
  when "up"
    depth -= amount
  when "down"
    depth += amount
  end
end

puts horizontal * depth # 1580000
