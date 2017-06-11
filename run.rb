#!/usr/bin/ruby
require_relative 'lib/data_util.rb'

DataUtil.load(ARGV[0])

game_payout = Game.get_payout.simplify
thirty_two_payout = ThirtyTwo.get_payout.simplify
three_putt_payout = ThreePutt.get_payout.simplify

payout = game_payout + thirty_two_payout + three_putt_payout
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

puts "Final Payout".red
puts payout.to_s

puts "Net Winnings".red
puts payout.net
