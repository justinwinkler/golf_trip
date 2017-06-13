#!/usr/bin/ruby
require_relative 'lib/data_util.rb'

DataUtil.load(ARGV[0])

game_payout = Game.get_payout.simplify
thirty_two_payout = ThirtyTwo.get_payout.simplify
three_putt_payout = ThreePutt.get_payout.simplify
barkie_payout = Barkie.get_payout.simplify
greenie_payout = Greenie.get_payout.simplify
nastie_payout = Nastie.get_payout.simplify
sandie_payout = Sandie.get_payout.simplify
expense_payout = Expense.get_payout.simplify

golf_payout =
  game_payout +
  thirty_two_payout +
  three_putt_payout +
  barkie_payout +
  greenie_payout +
  nastie_payout +
  sandie_payout
golf_payout = golf_payout.simplify

total_payout = golf_payout + expense_payout
total_payout = total_payout.simplify

Course.print_all
Round.print_all
Player.print_all
Game.print_all

puts "All Games Payout".red
puts game_payout.to_s
puts "All Games Net".red
puts game_payout.net

puts "32s Payout".red
puts thirty_two_payout.to_s
puts "32s Net".red
puts thirty_two_payout.net

puts "3-putt Payout".red
puts three_putt_payout.to_s
puts "3-putt Net".red
puts three_putt_payout.net

puts "Barkie Payout".red
puts barkie_payout.to_s
puts "Barkie Net".red
puts barkie_payout.net

puts "Greenie Payout".red
puts greenie_payout.to_s
puts "Greenie Net".red
puts greenie_payout.net

puts "Nastie Payout".red
puts nastie_payout.to_s
puts "Nastie Net".red
puts nastie_payout.net

puts "Sandie Payout".red
puts sandie_payout.to_s
puts "Sandie Net".red
puts sandie_payout.net

puts "Expense Payout".red
puts expense_payout.to_s
puts "Expense Net".red
puts expense_payout.net

puts "Golf Payout".red
puts golf_payout.to_s
puts "Golf Net".red
puts golf_payout.net

puts "Total Payout".red
puts total_payout.to_s
