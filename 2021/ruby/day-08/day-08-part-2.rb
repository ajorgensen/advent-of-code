#!/usr/bin/env ruby
require 'set'

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input = File.read(file_path)

def decode(segments)
  lookup = {}
  lookup_by_num = {}

  segments.each do |segment|
    char_set = segment.chars.to_set

    if char_set.length == 2
      lookup[char_set] = 1
      lookup_by_num[1] = char_set
    end

    if char_set.length == 3
      lookup[char_set] = 7
      lookup_by_num[7] = char_set
    end

    if char_set.length == 4
      lookup[char_set] = 4
      lookup_by_num[4] = char_set
    end

    if char_set.length == 7
      lookup[char_set] = 8
      lookup_by_num[8] = char_set
    end
  end

  segments.select { |s| s.size == 6 }.each do |segment|
    char_set = segment.chars.to_set

    if char_set.superset?(lookup_by_num[4])
      lookup[char_set] = 9
      lookup_by_num[9] = char_set
    elsif !char_set.superset?(lookup_by_num[1])
      lookup[char_set] = 6
      lookup_by_num[6] = char_set
    else
      lookup[char_set] = 0
      lookup_by_num[0] = char_set
    end
  end

  segments.select { |s| s.size == 5 }.each do |segment|
    char_set = segment.chars.to_set

    if char_set.subset?(lookup_by_num[6])
      lookup[char_set] = 5
      lookup_by_num[5] = char_set
    elsif char_set.superset?(lookup_by_num[1])
      lookup[char_set] = 3
      lookup_by_num[3] = char_set
    else
      lookup[char_set] = 2
      lookup_by_num[2] = char_set
    end
  end


  [lookup, lookup_by_num]
end

total = 0
input.split("\n").each do |line|
  input_segments, output_segments = line.split("|")
  input_segments = input_segments.chomp.split(" ")
  output_segments = output_segments.chomp.split(" ")

  lookup, lookup_by_num = decode(input_segments)

  number = output_segments.collect do |segment|
    lookup[segment.chars.to_set]
  end.join.to_i

  total += number
end

puts "Answer: #{total}"
