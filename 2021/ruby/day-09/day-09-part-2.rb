#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input = File.read(file_path)

grid = input.split("\n").map { |line| line.split("").map(&:to_i) }

class Grid
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.parse(raw_grid)
    grid = input.split("\n").map { |line| line.split("").map(&:to_i) }
  end

  def lowest_points
    low_points = []
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |height, col_idx|
        should_add = true

        #top
        unless row_idx == 0
          should_add = false if grid[row_idx - 1][col_idx] <= height
        end

        #left
        unless col_idx == 0
          should_add = false if grid[row_idx][col_idx - 1] <= height
        end

        #bottom
        unless row_idx == grid.size - 1
          should_add = false if grid[row_idx + 1][col_idx] <= height
        end

        #right
        unless col_idx == row.size - 1
          should_add = false if grid[row_idx][col_idx + 1] <= height
        end

        low_points << [row_idx, col_idx] if should_add
      end
    end

    low_points
  end

  def get(x,y)
    grid[x][y]
  end

  def adjacent_points(x,y)
    points = []

    unless x == 0
      points << [x-1, y]
    end

    #left
    unless y == 0
      points << [x, y-1]
    end
    
    #bottom
    unless x == grid.size - 1
      points << [x+1, y]
    end
 
    #right
    row = grid[x]
    unless y == row.size - 1
      points << [x, y+1]
    end

    points
  end

  def print_and_highlight(highlights)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |height, col_idx|
        if highlights.include? [row_idx, col_idx]
          print "#{colorize(height, 31)} "
        else
          print "#{height} "
        end

      end

      puts ""
    end
  end
  
  def colorize(str, color_code)
    "\e[#{color_code}m#{str}\e[0m"
  end
end

grid = Grid.new(grid)

basins = []
grid.lowest_points.each do |x,y|
  to_check = [[x,y]]
  checked = []
  basin = []

  while !to_check.empty?
    cur_x, cur_y = to_check.shift
    next if checked.include? [cur_x, cur_y]
    checked << [cur_x, cur_y]

    basin << [cur_x, cur_y]

    to_check += grid.adjacent_points(cur_x, cur_y).select { |x,y| grid.get(x,y) < 9 }
  end

  basins << basin
end

largest = basins.sort_by { |basin| basin.size }.reverse.take(3)

largest.each do |basin|
  grid.print_and_highlight(basin)
  puts
end

total = largest.map { |b| b.size }.reduce(:*)
puts "Answer: #{total}"

