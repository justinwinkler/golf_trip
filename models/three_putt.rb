require_relative 'payout.rb'
require_relative 'player.rb'

class ThreePutt
  COST = BigDecimal.new('0.50')

  attr_reader :round, :hole, :putter, :payees

  def initialize(round, hole, putter, payees)
    @round = round
    @hole = hole
    @putter = putter
    @payees = payees
  end

  def get_payout
    payout = Payout.new(Player.all)
    @payees.each do |payee|
      payout.owes(@putter, payee, COST) unless payee == @putter
    end
    return payout
  end

  def self.clear
    @@three_putts = nil
  end

  def self.all
    return @@three_putts
  end

  def self.load_all(trip)
    return @@three_putts if (defined? @@three_putts) && @@three_putts
    @@three_putts = []
    File.foreach('data/' + trip + '/3putts.txt').with_index do |l, i|
      values = l.strip.split(',')
      round = Round.get(values[0].to_i)
      hole = values[1].to_i
      putter = Player.get(values[2])
      payees = values[3].split('|').map {|s| Player.get(s)}
      @@three_putts << ThreePutt.new(round, hole, putter, payees)
    end
    return @@three_putts
  end

  def self.get_payout
    payout = nil
    @@three_putts.each do |three_putt|
      new_payout = three_putt.get_payout
      if !payout
        payout = new_payout
      else
        payout += new_payout
      end
    end
    return payout
  end
end
