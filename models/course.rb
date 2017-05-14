require_relative 'hole.rb'

class Course
  @@courses
  attr_accessor :name, :symbol, :holes

  def initialize
    @name = ""
    @symbol = ""
    @holes = []
  end

  def self.load_all
    course_files = Dir["courses/*"]
    @@courses = []
    course_files.each do |course_file|
      File.open(course_file, "r") do |file|
        course = Course.new
        pars = []
        handicaps = []
        index = 0
        file.each_line do |l|
          case index
          when 0
            course.name = l
          when 1
            course.symbol = l
          when 2
            pars = l.split(',')
          when 3
            handicaps = l.split(',')
          else
            throw "Course file has incorrect format: " + course_file
          end
          index += 1
        end
        (0...18).each do |i|
          hole = Hole.new
          hole.par = pars[i].to_i
          hole.handicap = handicaps[i].to_i
          course.holes << hole
        end
        @@courses << course
      end
    end
  end

  def self.print_all
    @@courses.each do |course|
      puts "-" * 75
      puts "Course: " + course.name
      print "Handi: "
      course.holes.each do |hole|
        print "%2d  " % hole.handicap
      end
      print "\n"
      par = 0
      print "Par:   "
      course.holes. each do |hole|
        par += hole.par
        print "%2d  " % hole.par
      end
      print "   Par: " + par.to_s
      puts "\n\n"
    end
  end
end

