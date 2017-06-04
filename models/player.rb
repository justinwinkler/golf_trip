require_relative 'player_round.rb'
require_relative '../lib/print_util.rb'

class Player
  attr_reader :name, :symbol, :handicap, :applied_handicap, :player_rounds

  def initialize(name, symbol, handicap)
    @name = name
    @symbol = symbol
    @handicap = handicap
    @applied_handicap = handicap.round
    @player_rounds = []
  end

  def to_s
    return @name
  end

  def add_player_round(player_round)
    @player_rounds << player_round
  end

  def self.all
    return @@players
  end

  def self.get(symbol)
    @@players.each do |player|
      if player.symbol == symbol
        return player
      end
    end
    throw "Unknown player: " + symbol
  end

  def self.clear
    @@players = nil
  end

  def self.load_all(trip)
    return @@players if (defined? @@players) && @@players
    @@players = []
    player_files = Dir["data/" + trip + "/players/*"]
    player_files.each do |player_file|
      name = nil
      symbol = nil
      handicap = nil
      all_scores = []
      File.foreach(player_file).with_index do |l, i|
        case i
        when 0
          name = l.strip
        when 1
          symbol = l.strip
        when 2
          handicap = l.strip.to_f
        else
          all_scores << l.split(',').map(&:to_i)
        end
      end
      player = Player.new(name, symbol, handicap)
      all_scores.each_with_index do |scores, i|
        player.add_player_round(PlayerRound.new(player, Round.get(i + 1), scores))
      end
      @@players << player
      @@players.sort_by!(&:name)
    end
    return @@players
  end

  def self.print_all
    @@players.each_with_index do |player, i|
      puts "Player #%d: %s (%.2f handicap, %d rounded)" %
        [i + 1, player.name, player.handicap, player.applied_handicap]
    end
  end

  def self.print_round(number)
    PrintUtil.print_round_header(number)
    @@players.each do |player|
      player.player_rounds[number - 1].print
    end
  end
end
