require_relative '../../../lib/data_util.rb'
require_relative '../../../models/game.rb'
require_relative '../../../models/games/skins.rb'

RSpec.describe Skins do
  before(:each) do
    DataUtil.load('example')
    @skins = nil
  end

  def skins
    return @skins if @skins
    @skins = Skins.new
    return @skins
  end

  describe '#run' do
    it 'returns expected matrix' do
      players_and_rounds = Game.players_and_rounds(Player.all, 2)
      players_and_rounds.each do |player_and_round|
        puts player_and_round[:player_round].net_scores.join(',')
      end
      team_matrix = DataUtil.team_matrix(players_and_rounds, 1, 2)
      result = skins.run(team_matrix, Course.get('BR'))
      expect(result[Player.all[0]]).to eq(3)
      expect(result[Player.all[1]]).to eq(6)
      expect(result[Player.all[2]]).to eq(3)
      expect(result[Player.all[3]]).to eq(1)
      expect(result[Player.all[4]]).to eq(7)
      expect(result[Player.all[5]]).to eq(0)
      expect(result[Player.all[6]]).to eq(0)
      expect(result[Player.all[7]]).to eq(14)
    end
  end
end
