#!/usr/bin/ruby
require_relative 'models/course.rb'
require_relative 'models/player.rb'
require_relative 'models/round.rb'

Course.load_all("data/courses/*")
Course.print_all

Round.load_all("data/rounds.txt")
Round.print_all

Player.load_all("data/players/*")
Player.print_all

Player.print_round(1)
