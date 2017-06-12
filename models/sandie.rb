require 'bigdecimal'

require_relative 'payout.rb'
require_relative 'player.rb'

class Sandie
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
    @@sandies = nil
  end

  def self.all
    return @@sandies
  end

  def self.load_all(trip)
    return @@sandies if (defined? @@sandies) && @@sandies
    @@sandies = []
    File.foreach('data/' + trip + '/sandies.txt').with_index do |l, i|
      values = l.strip.split(',')
      round = Round.get(values[0].to_i)
      hole = values[1].to_i
      player = Player.get(values[2])
      payers = values[3].split('|').map {|s| Player.get(s)}
      @@sandies << Sandie.new(round, hole, player, payers)
    end
    return @@sandies
  end

  def self.get_payout
    payout = Payout.new(Player.all)
    @@sandies.each do |sandie|
      payout += sandie.get_payout
    end
    return payout
  end
end
