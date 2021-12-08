#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input = File.read(file_path)

segments = 0
input.split("\n").each do |line|
  _, output_segments = line.split("|")
  output_segments = output_segments.chomp.split(" ")

  segments += output_segments.select { |s| s.size == 2 || s.size == 4 || s.size == 3 || s.size == 7 }.size
end

puts "Answer: #{segments}"
