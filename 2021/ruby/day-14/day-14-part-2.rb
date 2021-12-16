#!/usr/bin/env ruby

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path)

lines = input.split("\n")

template = lines.first

rules = {}
lines[1..lines.length].each do |line|
  rule, replacement = line.split(' -> ')
  rules[rule] = replacement
end

pairs = {}
template.split('').each_cons(2) do |p1, p2|
  key = [p1, p2].join('')
  pairs[key] ||= 0
  pairs[key] += 1
end

steps = 40
steps.times do |_i|
  new_pairs = {}
  pairs.each do |pair, count|
    new_pairs[pair[0] + rules[pair]] ||= 0
    new_pairs[pair[0] + rules[pair]] += count

    new_pairs[rules[pair] + pair[1]] ||= 0
    new_pairs[rules[pair] + pair[1]] += count
  end
  pairs = new_pairs
end

counts = {}
pairs.each do |pair, v|
  counts[pair[0]] ||= 0
  counts[pair[0]] += v
end

sorted = counts.sort_by { |_k, v| v }
max = sorted.last[1]
min = sorted.first[1]

puts max - min + 1
