#!/usr/bin/ruby
require_relative 'models/course.rb'
require_relative 'models/game.rb'
require_relative 'models/player.rb'
require_relative 'models/round.rb'

trip = 'example'

Course.load_all(trip)
Course.print_all

Round.load_all(trip)
Round.print_all

Player.load_all(trip)
Player.print_all

Game.load_all(trip)
Game.print_all

Game.run_all
