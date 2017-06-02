require_relative '../lib/data_util.rb'
require_relative 'player.rb'
require_relative 'games/skins.rb'
require_relative 'games/vegas.rb'

class Game
  attr_reader :player_matrix, :rules, :round, :players, :hole_count

  def initialize(rules, round, players, hole_count)
    @rules = rules
    @round = round
    @players = players
    @hole_count = hole_count
  end

  def run
    team_matrix =
      DataUtil.team_matrix(
        Game.players_and_rounds_matrix(players, round.number), hole_count)
    team_matrix.each_with_index do |hole, i|
      print "Hole " + (i + 1).to_s
      hole.each do |team|
        print ": " + team[0][:player].symbol + " & " + team[1][:player].symbol
      end
      puts
    end
    @player_matrix = rules.run(team_matrix, @round.course)
  end

  def to_s
    return "Round %s, %s" % [round.number, rules.class.name]
  end

  def self.players_and_rounds_matrix(players, round_number)
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

  def self.load_all(trip)
    return @@games if defined? @@games
    @@games = []
    File.foreach("data/" + trip + "/games.txt").with_index do |l, i|
      values = l.strip.split(',')
      round = Round.get(values[0].to_i)
      rules_class = get_rules_class(values[1])
      players = values[2].split('|').map do |symbol|
        Player.get(symbol)
      end
      hole_count = values[3].to_i
      game = Game.new(rules_class.new, round, players, hole_count)
      @@games << game
    end
    return @@games
  end

  def self.print_all
    @@games.each do |game|
      PrintUtil.print_matrix(game.players, game.player_matrix)
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

  def self.run_all
    @@games.each(&:run)
  end
end
