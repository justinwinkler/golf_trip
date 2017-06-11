require_relative 'payout.rb'
require_relative 'player.rb'

class ThirtyTwo
  POINT_COST = BigDecimal.new('0.25')

  attr_reader :round, :hole, :challengers, :putter, :putts

  def initialize(round, hole, challengers, putter, putts)
    @round = round
    @hole = hole
    @challengers = challengers
    @putter = putter
    @putts = putts
  end

  def get_payout
    payout = Payout.new(Player.all)
    challengers.each do |challenger|
      case @putts
      when 1
        payout.owes(challenger, @putter, POINT_COST * 3 * 2)
      when 2
        payout.owes(challenger, @putter, POINT_COST * 3)
      when 3
        payout.owes(@putter, challenger, POINT_COST * 2)
      else
        payout.owes(@putter, challenger, POINT_COST * 2 * 2)
      end
    end
    return payout
  end

  def self.clear
    @@thirty_twos = nil
  end

  def self.all
    return @@thirty_twos
  end

  def self.load_all(trip)
    return @@thirty_twos if (defined? @@thirty_twos) && @@thirty_twos
    @@thirty_twos = []
    File.foreach('data/' + trip + '/32s.txt').with_index do |l, i|
      values = l.strip.split(',')
      round = Round.get(values[0].to_i)
      hole = values[1].to_i
      challengers = values[2].split('|').map {|s| Player.get(s)}
      putter = Player.get(values[3])
      putts = values[4].to_i
      @@thirty_twos << ThirtyTwo.new(round, hole, challengers, putter, putts)
    end
    return @@thirty_twos
  end

  def self.get_payout
    payout = nil
    @@thirty_twos.each do |thirty_two|
      new_payout = thirty_two.get_payout
      if !payout
        payout = new_payout
      else
        payout += new_payout
      end
    end
    return payout
  end
end
