require 'colorize'

require_relative 'hole.rb'
require_relative '../lib/print_util.rb'

class Course
  attr_reader :name, :symbol, :holes

  def initialize(name, symbol, holes)
    @name = name
    @symbol = symbol
    @holes = holes
  end

  def to_s
    return @name
  end

  def self.load_all(path)
    return @@courses if defined? @@courses
    course_files = Dir["data/courses/*"]
    @@courses = []
    course_files = Dir[path]
    course_files.each do |course_file|
      name = nil
      symbol = nil
      pars = []
      handicaps = []
      File.foreach(course_file).with_index do |l, i|
        case i
        when 0
          name = l.strip
        when 1
          symbol = l.strip
        when 2
          pars = l.split(',').map(&:to_i)
          bad_format course_file if (pars.length != 18)
        when 3
          handicaps = l.split(',').map(&:to_i)
          bad_format course_file if (handicaps.length != 18)
        else
          bad_format course_file
        end
      end
      holes = []
      pars.each_with_index do |par, i|
        holes << Hole.new(par, handicaps[i])
      end
      @@courses << Course.new(name, symbol, holes)
    end
  end

  def self.bad_format(file)
    throw "Course file has incorrect format: " + file
  end

  def self.get(symbol)
    @@courses.each do |course|
      if course.symbol === symbol
        return course
      end
    end
    return nil
  end

  def self.print_all
    @@courses.each do |course|
      total_front = 0
      total_back = 0
      total = 0
      handicaps = []
      pars = []
      course.holes.each_with_index do |hole, i|
        pars << hole.par
        handicaps << hole.handicap
        total += hole.par
        if i < 9
          total_front += hole.par
        else
          total_back += hole.par
        end
      end
      PrintUtil.print_card_header("Course: " + course.to_s)
      PrintUtil.print_card_line('', (1..18).to_a)
      PrintUtil.print_card_line('Par', pars, total_front, total_back, total)
      PrintUtil.print_card_line('Hcp', handicaps)
      puts
    end
  end
end
