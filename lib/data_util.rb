require_relative '../models/course.rb'
require_relative '../models/game.rb'
require_relative '../models/player.rb'
require_relative '../models/round.rb'

class DataUtil
  def self.load(trip)
    Course.load_all(trip)
    Round.load_all(trip)
    Player.load_all(trip)
    Game.load_all(trip)
  end

  # Produces a matrix with 18 rows (1 per hole), each row an array of arrays,
  # the inner arrays representing pairs of players teamed up for that hole.
  def self.team_matrix(players, hole_count)
    result = []
    pairs = players.combination(2).to_a
    remaining_pairs = []
    count = 0
    hole_pairs = []
    (0...18).each do
      if count == hole_count
        count = 0
      elsif count < hole_count && count > 0
        result << hole_pairs
        count += 1
        next
      end
      count += 1
      remaining_pairs = pairs.clone if remaining_pairs.empty?
      hole_pairs = []
      players_included = []
      pairs_to_delete = []
      remaining_pairs.each_with_index do |pair, i|
        if !players_included.include?(pair[0]) && !players_included.include?(pair[1])
          players_included << pair[0]
          players_included << pair[1]
          hole_pairs << pair
          pairs_to_delete << i
        end
      end
      pairs_to_delete.reverse.each do |i|
        remaining_pairs.delete_at(i)
      end
      result << hole_pairs
    end
    return result
  end
end
