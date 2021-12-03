#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input = File.read(file_path)

numbers = input.split("\n")

o2 = numbers.map(&:chars)

o2[0].size.times do |idx|
  significant_bit = "1"

  significant_bit_count = o2.count { |o| o[idx] == "0" }

  if significant_bit_count > o2.size / 2.0
    significant_bit = "0"
  end

  o2.select! { |o| o[idx] == significant_bit }

  break if o2.count == 1
end

o2_level = o2.join.to_i(2)

co2 = numbers.map(&:chars)

co2[0].size.times do |idx|
  significant_bit = "0"

  significant_bit_count = co2.count { |o| o[idx] == "1" }

  if significant_bit_count < co2.size / 2.0
    significant_bit = "1"
  end

  co2.select! { |o| o[idx] == significant_bit }

  break if co2.count == 1
end

co2_level = co2.join.to_i(2)

puts o2_level * co2_level # 2372923
