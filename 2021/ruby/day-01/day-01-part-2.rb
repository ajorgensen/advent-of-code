#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input = File.read(file_path)

depths = input.split("\n").map(&:to_i)

windows = []
depths.each_cons(3) do |a,b,c| 
  windows << (a+b+c)
end

puts windows.each_cons(2).count { |a,b| b > a } # 1789
