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

payout =
  game_payout +
  thirty_two_payout +
  three_putt_payout +
  barkie_payout +
  greenie_payout +
  nastie_payout +
  sandie_payout

payout = payout.simplify

Course.print_all
Round.print_all
Player.print_all
Game.print_all

puts "Game Payout".red
puts game_payout.to_s

puts "32 Payout".red
puts thirty_two_payout.to_s

puts "3-putt Payout".red
puts three_putt_payout.to_s

puts "Barkie Payout".red
puts barkie_payout.to_s

puts "Greenie Payout".red
puts greenie_payout.to_s

puts "Nastie Payout".red
puts nastie_payout.to_s

puts "Sandie Payout".red
puts sandie_payout.to_s

puts "Final Payout".red
puts payout.to_s

puts "Net Winnings".red
puts payout.net
