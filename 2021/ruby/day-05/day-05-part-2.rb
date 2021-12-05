#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input = File.read(file_path)

class Line < Struct.new(:x1, :y1, :x2, :y2)
  def vertical?
    y1 == y2
  end

  def horizontal?
    x1 == x2
  end

  def points
    max_x = [x1, x2].max
    min_x = [x1, x2].min

    max_y = [y1, y2].max
    min_y = [y1, y2].min

    xs = (min_x..max_x).to_a
    ys = (min_y..max_y).to_a

    if x1 > x2
      xs = xs.reverse
    end

    if y1 > y2
      ys = ys.reverse
    end

    points = []
    if vertical?
      xs.length.times do |i|
        points << [xs[i] || x2, ys[i] || y2]
      end
    elsif horizontal?
      ys.length.times do |i|
        points << [xs[i] || x2, ys[i] || y2]
      end
    else
      points = xs.zip(ys)
    end

    points
  end
end

input = input.split("\n")
  .map do |line| 
    a, b = line.split(" -> ")
    x1,y1 = a.split(",")
    x2,y2 = b.split(",")
    Line.new(x1.to_i,y1.to_i,x2.to_i,y2.to_i)
  end

points = []
input.each do |lines|
  points += lines.points
end

answer = points.tally.select { |k,v| v > 1 }.count
puts "Answer: #{answer}"
