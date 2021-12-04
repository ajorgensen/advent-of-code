#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input = File.read(file_path)

input = input.split("\n\n")

numbers = input[0].split(",").map(&:to_i)
boards = input[1..-1].map do |board| 
  board.split("\n").map { |line| line.split(" ").map(&:to_i).map { |num| { :num => num, :marked => false } } }
end

def board_won?(board)
  # horizontal
  board.each do |row|
    if row.select { |item| !item[:marked] }.empty?
      return true
    end
  end

  #vertical
  board.transpose.each do |col|
    if col.select { |item| !item[:marked] }.empty?
      return true
    end
  end

  # diagonal
  i = 0
  board.each do |row|
    return false if row[i][:marked] == false
    i += 1
  end

  true
end

def calculate_score(board, last_number)
  total = 0
  board.each do |row|
    row.each do |item|
      unless item[:marked]
        total += item[:num]
      end
    end
  end

  total * last_number
end

numbers.each do |num|
  boards.each do |board|
    board.each do |row|
      row.each do |item|
        item[:marked] = true if item[:num] == num
      end

      if board_won?(board)
        puts "Answer: #{calculate_score(board, num)}" # 15561
        exit
      end
    end
  end
end

