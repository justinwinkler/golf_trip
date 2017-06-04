# Team scores are combined for each hole, low first, e.g. 4 + 5 = 45.
# If any team member scores birdie, all other teams that did not have at least
# one player with a birdie have their score flipped, e.g. 45 -> 54.
# Same applies for teams where one member has an eagle, except those teams that
# are flipped are then also doubled, e.g. 45 -> 108. If the team being flipped
# had a birdie, they are not doubled.
# Double-digit player scores carry over, e.g. 4 + 10 -> 50, but any flipping
# is done before the combination, e.g. 4 + 10 -> 10 + 4 -> 104
class Vegas
  def run(team_matrix, course)
    player_points = {}
    team_matrix[0].each do |team|
      player_points[team[0][:player]] = 0
      player_points[team[1][:player]] = 0
    end
    team_matrix.each_with_index do |hole, i|
      team_scores = []
      low_score = 100
      hole.each do |team|
        team_score = {
          players: [team[0][:player], team[1][:player]],
          scores: [
            team[0][:player_round].net_scores[i],
            team[1][:player_round].net_scores[i]
          ]
        }
        team_score[:scores].sort!
        low_score = team_score[:scores][0] if team_score[:scores][0] < low_score
        team_scores << team_score
      end
      par = course.holes[i].par
      reverse_scores = false
      multiplier = nil
      if low_score < par
        reverse_scores = true
        multiplier = par - low_score
      end
      team_scores.each do |team_score|
        if reverse_scores && !team_score[:scores].include?(low_score)
          this_multiplier = multiplier
          if team_score[:scores][0] < par
            this_multiplier -= (par - team_score[:scores][0])
          end
          team_score[:scores].reverse!
          team_score[:scores].map! {|s| s * this_multiplier}
        end
        score = Vegas.score(team_score[:scores])
        player_points[team_score[:players][0]] += score
        player_points[team_score[:players][1]] += score
      end
    end
    max_score = nil
    player_points.each do |player, score|
      if !max_score || score > max_score
        max_score = score
      end
    end
    player_points.each do |player, score|
      player_points[player] = (score - max_score) * -1
    end
    return player_points
  end

  def self.score(team_score_array)
    score1 = team_score_array[0] + (team_score_array[1] / 10)
    score2 = team_score_array[1] % 10
    return (score1.to_s + score2.to_s).to_i
  end
end
