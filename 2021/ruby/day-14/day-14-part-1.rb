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

def do_step(template, rules)
  output = []

  prev_sub = false
  template.split('').each_cons(2) do |p1, p2|
    key = [p1, p2].join('')

    if rules[key]
      output << if prev_sub
                  [rules[key], p2]
                else
                  [p1, rules[key], p2]
                end
      prev_sub = true
    else
      prev_sub = false
      output << [p1, p2]
    end
  end
  output.join('')
end

10.times do |_i|
  template = do_step(template, rules)
end

results = template.split('').tally
results = results.sort_by { |_k, v| v }

answer = results.last[1] - results.first[1]

puts "Answer: #{answer}"
