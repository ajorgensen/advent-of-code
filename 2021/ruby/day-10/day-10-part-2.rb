#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input = File.read(file_path)

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

def corrupt?(line)
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
        return true
      end
    end
  end

  return false
end

def complete(line)
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
        return true
      end
    end
  end

  to_complete = []
  while !stack.empty?
    char = stack.pop
    opp = opposite(char)
    to_complete << opp
  end

  to_complete
end

lines = input.split("\n")

incomplete = lines.select { |line| !corrupt?(line) }

points = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4,
}

scores = incomplete.collect do |line|
  completion_string = complete(line)

  score = 0
  completion_string.each do |char|
    score *= 5
    score += points[char]
  end

  score
end.sort

puts "Answer: #{scores[scores.length / 2]}"

