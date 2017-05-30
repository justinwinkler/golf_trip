require_relative '../../lib/data_util.rb'
require_relative '../../models/game.rb'
require_relative '../../models/games/vegas.rb'

RSpec.describe Game do
  before(:each) do
    DataUtil.load('example')
    @game = Game.all[0]
  end

  describe "initializion" do
    it "allows access of all supplied params" do
      expect(@game.rules).to be_a(Vegas)
      expect(@game.round).to eq(Round.get(1))
      expect(@game.players[0]).to eq(Player.get('PLAYER1'))
      expect(@game.hole_count).to eq(1)
    end
  end
end
