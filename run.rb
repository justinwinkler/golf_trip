#!/usr/bin/ruby
require_relative 'models/course.rb'
require_relative 'models/player.rb'
require_relative 'models/round.rb'

trip = 'example'

Course.load_all(trip)
Course.print_all

Round.load_all(trip)
Round.print_all

Player.load_all(trip)
Player.print_all

Player.print_round(1)
