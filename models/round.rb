class Round
  attr_reader :number, :course

  def initialize(number, course)
    @number = number
    @course = course
  end

  def to_s
    return "Round #%d @ %s" % [@number, @course.to_s]
  end

  def self.get(number)
    @@rounds.each do |round|
      if round.number === number
        return round
      end
    end
    return nil
  end

  def self.clear
    @@rounds = nil
  end

  def self.load_all(trip)
    return @@rounds if (defined? @@rounds) && @@rounds
    @@rounds = []
    File.foreach("data/" + trip + "/rounds.txt").with_index do |l, i|
      values = l.strip.split(',')
      course = Course.get(values[1])
      @@rounds << Round.new(values[0].to_i, course)
    end
  end

  def self.print_all
    puts @@rounds
  end
end
