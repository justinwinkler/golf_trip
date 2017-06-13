class PlayerRound
  attr_reader :player, :round, :gross_scores, :net_scores

  def initialize(player, round, gross_scores)
    @player = player
    @round = round
    @gross_scores = gross_scores
    @net_scores = calculate_net_scores
  end

  def print
    PrintUtil.print_card_header(
      "%s Round %s at %s" % [player.name, round.number, round.course.name])
    total_front = 0
    total_back = 0
    total = 0
    @gross_scores.each_with_index do |score, i|
      total += score
      if i < 9
        total_front += score
      else
        total_back += score
      end
    end
    PrintUtil.print_card_line("Gross", @gross_scores, total_front, total_back, total)
    total_front = 0
    total_back = 0
    total = 0
    @net_scores.each_with_index do |score, i|
      total += score
      if i < 9
        total_front += score
      else
        total_back += score
      end
    end
    PrintUtil.print_card_line("Net", @net_scores, total_front, total_back, total)
    puts
  end

  private

  def calculate_net_scores
    result = []
    per_hole = player.applied_handicap / 18
    remainder = player.applied_handicap % 18
    (0...18).each do |i|
      score = @gross_scores[i] - per_hole
      score -= 1 if remainder >= round.course.holes[i].handicap
      result << score
    end
    return result
  end
end
