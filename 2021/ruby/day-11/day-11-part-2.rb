#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input = File.read(file_path)

def clear_terminal
  puts "\e[H\e[2J"
end

def colorize(str, color_code)
  "\e[#{color_code}m#{str}\e[0m"
end

class Grid
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def pretty_print
    grid.each do |row|
      row.each do |col|

        if col == 0
          print "#{colorize(col, 34)} "
        else
          print "#{col} "
        end
      end
      puts ""
    end
  end

  def each(&block)
    grid.each_with_index do |row, x|
      row.each_with_index do |elem, y|
        yield elem, x, y
      end
    end
  end

  def set(x,y,val)
    grid[x][y] = val
  end

  def get(x,y)
    grid[x][y]
  end

  def adjacent(x, y)
    adjacent = []

    if x - 1 >= 0 && y - 1 >= 0
      adjacent << [x - 1, y - 1]
    end

    if x - 1 >= 0
      adjacent << [x - 1, y]
    end

    if x - 1 >= 0 && y + 1 < grid.first.length
      adjacent << [x - 1, y + 1]
    end

    if y - 1 >= 0
      adjacent << [x, y - 1]
    end

    if y + 1 < grid.first.length
      adjacent << [x, y + 1]
    end

    if x + 1 < grid.length && y - 1 >= 0
      adjacent << [x + 1, y - 1]
    end

    if x + 1 < grid.length
      adjacent << [x + 1, y]
    end

    if x + 1 < grid.length && y + 1 < grid.first.length
      adjacent << [x + 1, y + 1]
    end

    adjacent
  end
end

def do_step(grid)
  flashes = 0
  grid.each { |elem,x,y| grid.set(x,y, elem + 1) }
  to_flash = []
  grid.each { |elem,x,y| to_flash << [x,y] if elem == 10 }

  while !to_flash.empty?
    flashes += 1
    x,y = to_flash.pop

    adjacent = grid.adjacent(x,y)
    adjacent.each do |x,y|
      elem = grid.get(x,y)
      
      if elem < 9
        grid.set(x,y,elem + 1)
      elsif elem == 9
        to_flash << [x,y]
        grid.set(x,y,elem + 1)
      end
    end
  end

  grid.each { |elem,x,y| grid.set(x,y,0) if elem >= 10 }
  flashes
end

grid = input.split("\n").map { |l| l.split("").map(&:to_i) }
grid = Grid.new(grid)

clear_terminal
puts "Before any steps"
grid.pretty_print

flashes = 0
all_flash = false
step = 0
while !all_flash do
  step += 1
  clear_terminal

  flashes += do_step(grid)

  all = true
  grid.each { |elem,x,y| all = false if elem != 0 }
  all_flash = all

  puts "After Step #{step}"
  grid.pretty_print
end

puts "All octopus will flash at step #{step}"
