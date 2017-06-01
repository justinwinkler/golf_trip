# Team scores are combined for each hole, low first, e.g. 4 + 5 = 45.
# If any team member scores birdie, all other teams that did not have at least
# one player with a birdie have their score flipped, e.g. 45 -> 54.
# Same applies for teams where one member has an eagle, except those teams that
# are flipped are then also doubled, e.g. 45 -> 108
# Double-digit player scores carry over, e.g. 4 + 10 -> 50, but any flipping
# is done before the combination, e.g. 4 + 10 -> 10 + 4 -> 104
class Vegas
  def run(team_matrix, course)
    total_points = {}
    team_matrix[0].each do |team|
      total_points[team[0][:player]] = 0
      total_points[team[1][:player]] = 0
    end
    all_scores = []
    team_matrix.each_with_index do |hole, i|
      hole_scores = []
      hole.each do |team|
        team_score = {
          players: [team[0][:player], team[1][:player]],
          scores: [
            team[0][:player_round].net_scores[i],
            team[1][:player_round].net_scores[i]
          ]
        }
        team_score[:scores].sort!
        hole_scores << team_score
      end
      all_scores << hole_scores
    end
    return []
  end

  def self.score(team_score_array)
    score1 = team_score_array[0] + (team_score_array[1] / 10)
    score2 = team_score_array[1] % 10
    return (score1.to_s + score2.to_s).to_i
  end
end
