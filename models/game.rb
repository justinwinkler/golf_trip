require 'bigdecimal'
require_relative '../lib/data_util.rb'
require_relative 'payout.rb'
require_relative 'player.rb'
require_relative 'games/skins.rb'
require_relative 'games/vegas.rb'

class Game
  attr_reader :rules, :round, :players, :hole_count, :team_size, :options,
    :team_matrix, :player_points, :price_per_point

  def initialize(rules, round, players, hole_count, team_size, price_per_point, options)
    @rules = rules
    @round = round
    @players = players
    @hole_count = hole_count
    @team_size = team_size
    @price_per_point = price_per_point
    @options = options
    players_and_rounds = Game.players_and_rounds(@players, @round.number)
    @team_matrix = DataUtil.team_matrix(players_and_rounds, @hole_count, @team_size)
  end

  def get_payout
    @player_points = rules.run(@team_matrix, @round.course)
    return Payout.new(players).add_points(@player_points, price_per_point)
  end

  def to_s
    return "Round %s, %s" % [round.number, rules.class.name]
  end

  def self.players_and_rounds(players, round_number)
    return players.map do |player|
      player_round = player.player_rounds.find do |x|
        x.round.number == round_number
      end
      {player: player, player_round: player_round}
    end
  end

  def self.all
    return @@games
  end

  def self.get_payout
    payout = Payout.new(Player.all)
    @@games.each do |game|
      payout += game.get_payout
    end
    return payout
  end

  def self.clear
    @@games = nil
  end

  def self.load_all(trip)
    return @@games if (defined? @@games) && @@games
    @@games = []
    File.foreach("data/" + trip + "/games.txt").with_index do |l, i|
      values = l.strip.split(',')
      round = Round.get(values[0].to_i)
      rules_class = get_rules_class(values[1])
      players = values[2].split('|').map do |symbol|
        Player.get(symbol)
      end
      hole_count = values[3].to_i
      team_size = values[4].to_i
      options = {}
      price_per_point = BigDecimal.new(values[5])
      (values[6] || '').split('|').each do |key_value|
        options[key_value.split('=')[0].to_sym] = key_value.split('=')[1]
      end
      game = Game.new(
        rules_class.new, round, players, hole_count, team_size, price_per_point, options)
      @@games << game
    end
    return @@games
  end

  def self.print_all
    @@games.each do |game|
      puts "Round #%s - %s : Teams".red %
        [game.round.number.to_s, game.rules.class.name]
      game.team_matrix.each_with_index do |hole, i|
        print 'Hole ' + (i + 1).to_s
        hole.each do |team|
          print ' : '
          team.each_with_index do |player, j|
            print ' & ' if j > 0
            print player[:player].symbol
          end
        end
        puts
      end
    end
  end

  def self.get_rules_class(symbol)
    case symbol
    when 'VEGAS'
      return Vegas
    when 'SKINS'
      return Skins
    else
      throw "Invalid game: " + symbol
    end
  end
end
