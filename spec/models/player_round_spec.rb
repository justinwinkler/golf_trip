require_relative '../../lib/data_util.rb'
require_relative '../../models/player_round.rb'

RSpec.describe PlayerRound do
  before(:each) do
    DataUtil.load('example')
    @player_round = Player.get('PLAYER1').player_rounds[0]
  end

  describe "initializion" do
    it "allows access of all supplied params" do
      expect(@player_round.player).to eq(Player.get('PLAYER1'))
      expect(@player_round.round).to eq(Round.get(1))
      expect(@player_round.gross_scores).to eq(
        [4,4,6,3,4,6,3,5,5,4,4,6,3,5,6,4,5,6])
      expect(@player_round.net_scores).to eq(
        [3,3,6,2,3,6,3,4,4,3,4,5,2,4,5,4,5,5])
    end
  end
end
