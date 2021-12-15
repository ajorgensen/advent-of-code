#!/usr/bin/env ruby

file_path = File.expand_path("../input.txt", __FILE__)
input = File.read(file_path)

dots = {}
folds = []

width = 0
height = 0
input.split("\n").each do |line|
  if line.include? "fold"
    instruction = line.split(" ").last
    direction, amount = instruction.split("=")
    folds << [direction, amount.to_i]
    next
  elsif line == ""
    next
  end

  x,y = line.split(",").map(&:to_i)
  width = x if x > width
  height = y if y > height

  dots[[x,y]] = true
end

def fold_y(dots, fold_y)
  new_dots = {}
  dots.each do |k, v|
    x,y = k

    if y < fold_y
      new_dots[k] = v
    else
      new_y = fold_y - (y - fold_y)
      new_dots[[x,new_y]] = true
    end

  end

  new_dots
end

def fold_x(dots, fold_x)
  new_dots = {}
  dots.each do |k, v|
    x,y = k

    if x < fold_x
      new_dots[k] = v
    else
      new_x = fold_x - (x - fold_x)
      new_dots[[new_x,y]] = true
    end

  end

  new_dots
end

def print_dots(width, height, dots)
  dots.each do |k, v|
    x,y = k
  end

  (height+1).times do |y|
    (width+1).times do |x|
      if dots[[x,y]]
        print colorize("#", 31)
      else
        print "."
      end
    end
    puts ""
  end
end

def colorize(str, color_code)
  "\e[#{color_code}m#{str}\e[0m"
end

folds.each do |direction, amount|
  puts "Folding: #{direction} #{amount}"

  if direction == "x"
    width = amount - 1
    dots = fold_x(dots, amount)
  elsif direction == "y"
    height = amount - 1
    dots = fold_y(dots, amount)
  end
end

print_dots(width, height, dots)
puts "Visible Dots: #{dots.length}"
