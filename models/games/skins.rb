class Skins
  def run(team_matrix, course, options = {})
    player_points = {}
    team_matrix[0].each do |team|
      team.each do |player|
        player_points[player[:player]] = 0
      end
    end
    carryover = 0
    team_matrix.each_with_index do |hole, i|
      puts "hole " + (i + 1).to_s
      team_scores = []
      low_score = 1_000
      low_score_skin = false
      hole.each do |team|
        players = []
        scores = []
        team.each do |player|
          players << player[:player]
          scores << player[:player_round].net_scores[i]
        end
        team_score = {
          players: players,
          score: scores.sort[0]
        }
        puts team_score[:score]
        if team_score[:score] < low_score
          low_score = team_score[:score] 
          low_score_skin = true
        elsif team_score[:score] == low_score
          low_score_skin = false
        end
        team_scores << team_score
      end
      if low_score_skin
        team_scores.each do |team_score|
          if team_score[:score] == low_score
            team_score[:players].each do |player|
              player_points[player] += 1 + carryover
            end
          end
        end
        carryover = 0
      else
        carryover += 1
      end
    end
    min_score = nil
    player_points.each do |player, score|
      if !min_score || score < min_score
        min_score = score
      end
    end
    player_points.each do |player, score|
      player_points[player] = score - min_score
    end
    return player_points
  end
end
