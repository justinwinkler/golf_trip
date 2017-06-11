#!/usr/bin/ruby
require_relative 'lib/data_util.rb'

DataUtil.load(ARGV[0])

payout = Game.get_payout.simplify
thirty_two_payout = ThirtyTwo.get_payout.simplify
three_putt_payout = ThreePutt.get_payout.simplify
payout += thirty_two_payout
payout += three_putt_payout
payout = payout.simplify

Course.print_all
Round.print_all
Player.print_all
Game.print_all

puts "32 Payout".red
thirty_two_payout = ThirtyTwo.get_payout.simplify
payout += thirty_two_payout
puts thirty_two_payout.to_s

puts "3-putt Payout".red
three_putt_payout = ThreePutt.get_payout.simplify
payout += three_putt_payout
puts three_putt_payout.to_s

puts "Final Payout".red
payout = payout.simplify
puts payout.to_s
puts "Net Winnings".red
puts payout.net
