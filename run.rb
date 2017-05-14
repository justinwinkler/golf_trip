#!/usr/bin/ruby
require_relative 'models/course.rb'

Course.load_all
Course.print_all
