require 'bigdecimal'

require_relative 'payout.rb'
require_relative 'player.rb'

class Greenie
  COST = BigDecimal.new('0.50')

  attr_reader :round, :hole, :player, :payers

  def initialize(round, hole, player, payers)
    @round = round
    @hole = hole
    @player = player
    @payers = payers
  end

  def get_payout
    payout = Payout.new(Player.all)
    @payers.each do |payer|
      payout.owes(payer, @player, COST) unless payer == @player
    end
    return payout
  end

  def self.clear
    @@greenies = nil
  end

  def self.all
    return @@greenies
  end

  def self.load_all(trip)
    return @@greenies if (defined? @@greenies) && @@greenies
    @@greenies = []
    File.foreach('data/' + trip + '/greenies.txt').with_index do |l, i|
      values = l.strip.split(',')
      round = Round.get(values[0].to_i)
      hole = values[1].to_i
      player = Player.get(values[2])
      payers = values[3].split('|').map {|s| Player.get(s)}
      @@greenies << Greenie.new(round, hole, player, payers)
    end
    return @@greenies
  end

  def self.get_payout
    payout = Payout.new(Player.all)
    @@greenies.each do |greenie|
      payout += greenie.get_payout
    end
    return payout
  end
end
