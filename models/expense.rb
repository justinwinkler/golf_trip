require 'bigdecimal'

require_relative 'payout.rb'
require_relative 'player.rb'

class Expense
  attr_reader :amount, :player, :all_players

  def initialize(amount, player, all_players)
    @amount = amount
    @player = player
    @all_players = all_players
  end

  def get_payout
    payout = Payout.new(Player.all)
    amount_per_player = amount / all_players.size
    all_players.each do |other_player|
      if other_player != @player
        payout.owes(other_player, @player, amount_per_player)
      end
    end
    return payout
  end

  def self.clear
    @@expenses = nil
  end

  def self.all
    return @@expenses
  end

  def self.load_all(trip)
    return @@expenses if (defined? @@expenses) && @@expenses
    @@expenses = []
    File.foreach('data/' + trip + '/expenses.txt').with_index do |l, i|
      values = l.strip.split(',')
      amount = BigDecimal.new(values[0])
      player = Player.get(values[1])
      all_players = values[2].split('|').map {|s| Player.get(s)}
      @@expenses << Expense.new(amount, player, all_players)
    end
    return @@expenses
  end

  def self.get_payout
    payout = Payout.new(Player.all)
    @@expenses.each do |expense|
      payout += expense.get_payout
    end
    return payout
  end
end
