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
      players_and_rounds = Game.players_and_rounds(Player.all, 1)
      team_matrix = DataUtil.team_matrix(players_and_rounds, 1, 2)
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
      expect(Vegas.score([5,4], false, {})).to eq(54)
    end

    it 'handles double-digit as the first score' do
      expect(Vegas.score([10,5], false, {})).to eq(105)
    end

    it 'handles double-digit as the second score' do
      expect(Vegas.score([5,10], false, {})).to eq(60)
    end

    it 'handles double-digit as both scores' do
      expect(Vegas.score([11,10], false, {})).to eq(120)
    end

    it 'reverse score if necessary' do
      expect(Vegas.score([3,4], true, {})).to eq(43)
    end

    it 'selects alternate indexes from options' do
      expect(Vegas.score([3,4,5,6], false, {score_indexes: '0&2'})).to eq(35)
    end

    it 'reverses score after indexes selected' do
      expect(Vegas.score([3,4,5,6], true, {score_indexes: '0&2'})).to eq(53)
    end
  end

  context 'when all players should be equal' do
    before(:each) do
      DataUtil.load('example2')
    end

    describe '#run' do
      it 'returns expected matrix' do
        players_and_rounds = Game.players_and_rounds(Player.all, 1)
        team_matrix = DataUtil.team_matrix(players_and_rounds, 1, 2)
        result = vegas.run(team_matrix, Course.get('BR'))
        expect(result[Player.all[0]]).to eq(0)
        expect(result[Player.all[1]]).to eq(0)
        expect(result[Player.all[2]]).to eq(0)
        expect(result[Player.all[3]]).to eq(0)
      end
    end
  end

  context 'with teams of 4, taking best and 3rd best scores' do
    before(:each) do
      DataUtil.load('example3')
    end

    describe '#run' do
      it 'returns expected matrix' do
        players_and_rounds = Game.players_and_rounds(Player.all, 1)
        team_matrix = DataUtil.team_matrix(players_and_rounds, 18, 4)
        result = vegas.run(team_matrix, Course.get('OK'), {:score_indexes => '0&2'})
        expect(result[Player.all[0]]).to eq(0)
        expect(result[Player.all[1]]).to eq(0)
        expect(result[Player.all[2]]).to eq(0)
        expect(result[Player.all[3]]).to eq(0)
        expect(result[Player.all[4]]).to eq(0)
        expect(result[Player.all[5]]).to eq(0)
        expect(result[Player.all[6]]).to eq(0)
        expect(result[Player.all[7]]).to eq(0)
      end
    end
  end
end
