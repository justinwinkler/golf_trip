require 'bigdecimal'

require_relative 'payout.rb'
require_relative 'player.rb'

class Nastie
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
    @@nasties = nil
  end

  def self.all
    return @@nasties
  end

  def self.load_all(trip)
    return @@nasties if (defined? @@nasties) && @@nasties
    @@nasties = []
    File.foreach('data/' + trip + '/nasties.txt').with_index do |l, i|
      values = l.strip.split(',')
      round = Round.get(values[0].to_i)
      hole = values[1].to_i
      player = Player.get(values[2])
      payers = values[3].split('|').map {|s| Player.get(s)}
      @@nasties << Nastie.new(round, hole, player, payers)
    end
    return @@nasties
  end

  def self.get_payout
    payout = Payout.new(Player.all)
    @@nasties.each do |nastie|
      payout += nastie.get_payout
    end
    return payout
  end
end
