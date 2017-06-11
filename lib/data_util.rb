require_relative '../models/course.rb'
require_relative '../models/game.rb'
require_relative '../models/player.rb'
require_relative '../models/round.rb'
require_relative '../models/thirty_two.rb'

class DataUtil
  def self.clear
    Course.clear
    Round.clear
    Player.clear
    Game.clear
    ThirtyTwo.clear
  end

  def self.load(trip)
    DataUtil.clear
    Course.load_all(trip)
    Round.load_all(trip)
    Player.load_all(trip)
    Game.load_all(trip)
    ThirtyTwo.load_all(trip)
  end

  # Produces a matrix with 18 rows (1 per hole), each row an array of arrays,
  # the inner arrays representing teams of players teamed up for that hole.
  def self.team_matrix(players, hole_count, team_size)
    result = []
    teams = players.combination(team_size).to_a
    remaining_teams = []
    count = 0
    hole_teams = []
    (0...18).each do
      if count == hole_count
        count = 0
      elsif count < hole_count && count > 0
        result << hole_teams
        count += 1
        next
      end
      count += 1
      remaining_teams = teams.clone if remaining_teams.empty?
      hole_teams = []
      players_included = []
      teams_to_delete = []
      remaining_teams.each_with_index do |team, i|
        if (players_included & team).empty?
          players_included.push(*team)
          hole_teams << team
          teams_to_delete << i
        end
      end
      teams_to_delete.reverse.each do |i|
        remaining_teams.delete_at(i)
      end
      result << hole_teams
    end
    return result
  end
end
