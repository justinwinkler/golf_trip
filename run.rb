#!/usr/bin/ruby
require_relative 'lib/data_util.rb'

DataUtil.load('example2')

Course.print_all
Round.print_all
Player.print_all

Game.run_all

Game.print_all
