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
      team_matrix = DataUtil.team_matrix(players_and_rounds, 1, 2)
      result = skins.run(team_matrix, Course.get('OK'))
      #expect(result[Player.all[0]]).to eq(49)
    end
  end

  describe '.score' do
    it 'handles normal scores' do
    end
  end
end
