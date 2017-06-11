#!/usr/bin/ruby
require_relative 'lib/data_util.rb'

DataUtil.load(ARGV[0])

Course.print_all
Round.print_all
Player.print_all

payout = Game.get_payout
payout += ThirtyTwo.get_payout
payout += ThreePutt.get_payout
payout = payout.simplify

Game.print_all
puts payout.to_s
