#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input = File.read(file_path)

commands = input.split("\n")

depth = 0
horizontal = 0
aim = 0

commands.each do |cmd|
  direction, amount = cmd.split
  amount = amount.to_i

  case direction
  when "forward"
    horizontal += amount
    depth += (aim * amount)
  when "up"
    aim -= amount
  when "down"
    aim += amount
  end
end

puts depth * horizontal # 1251263225
