#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input = File.read(file_path)

# 9 is highest
# 0 is the lowest
#
# Risk level of a low point is 1 + its height

#input = "2199943210
#3987894921
#9856789892
#8767896789
#9899965678"

grid = input.split("\n").map { |line| line.split("").map(&:to_i) }

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

    low_points << height + 1 if should_add
  end
end

puts "Answer: #{low_points.sum}"
