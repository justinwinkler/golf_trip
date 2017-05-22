require_relative 'player.rb'
require_relative 'games/skins.rb'
require_relative 'games/vegas.rb'

class Game
  attr_reader :rules, :round, :player_rounds

  def initialize(rules, round, player_rounds)
    @rules = rules
    @round = round
    @player_rounds = player_rounds
  end

  def to_s
    return "Round %s, %s" % [round.number, rules.class.name]
  end

  def self.load_all(trip)
    return @@games if defined? @@games
    @@games = []
    File.foreach("data/" + trip + "/games.txt").with_index do |l, i|
      values = l.strip.split(',')
      round = Round.get(values[0].to_i)
      rules_class = get_rules_class(values[1])
      game = Game.new(rules_class.new, round, Player.get_player_rounds(round.number))
      @@games << game
    end
    return @@games
  end

  def self.print_all
    puts "TODO"
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
    @@games.each do |game|
      puts game
    end
  end
end
