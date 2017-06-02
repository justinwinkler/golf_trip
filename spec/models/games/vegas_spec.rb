require_relative '../../../lib/data_util.rb'
require_relative '../../../models/game.rb'
require_relative '../../../models/games/vegas.rb'

RSpec.describe Vegas do
  before(:each) do
    DataUtil.load('example')
    @vegas = nil
  end

  def vegas
    return @vegas if @vegas
    @vegas = Vegas.new
    return @vegas
  end

  describe '#run' do
    it 'returns expected matrix' do
      players_and_rounds_matrix = Game.players_and_rounds_matrix(Player.all, 1)
      team_matrix = DataUtil.team_matrix(players_and_rounds_matrix, 1)
      result = vegas.run(team_matrix, Course.get('OK'))
      expect(result[Player.all[0]]).to eq(49)
      expect(result[Player.all[1]]).to eq(51)
      expect(result[Player.all[2]]).to eq(0)
      expect(result[Player.all[3]]).to eq(66)
      expect(result[Player.all[4]]).to eq(43)
      expect(result[Player.all[5]]).to eq(77)
      expect(result[Player.all[6]]).to eq(98)
      expect(result[Player.all[7]]).to eq(34)
    end
  end

  describe '.score' do
    it 'handles normal scores' do
      expect(Vegas.score([5,4])).to eq(54)
    end

    it 'handles double-digit as the first score' do
      expect(Vegas.score([10,5])).to eq(105)
    end

    it 'handles double-digit as the second score' do
      expect(Vegas.score([5,10])).to eq(60)
    end

    it 'handles double-digit as both scores' do
      expect(Vegas.score([11,10])).to eq(120)
    end
  end
end
