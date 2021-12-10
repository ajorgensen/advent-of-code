#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input = File.read(file_path)

lines = input.split("\n")

def is_starting?(char)
  char == "(" || char == "[" || char == "{" || char == "<"
end

def is_ending?(char)
  char == ")" || char == "]" || char == "}" || char == ">"
end

def opposite(char)
  case char
  when "("
    ")"
  when "("
    ")"
  when "["
    "]"
  when "]"
    "["
  when "<"
    ">"
  when ">"
    "<"
  when "{"
    "}"
  when "}"
    "{"
  end
end

points = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}

total_score = 0
lines.each do |line|
  chars = line.split("")

  stack = []
  chars.each do |char|
    if is_starting?(char)
      stack.push(char)
    end

    if is_ending?(char)
      other = stack.pop
      expected = opposite(other)
      if expected != char
        total_score += points[char]
        puts "Corrupt: #{line}"
        break
      end
    end

  end
end

puts "Answer: #{total_score}"
