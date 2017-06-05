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

  describe ".players_and_rounds" do
    it "produces expected matrix" do
      result = Game.players_and_rounds(Player.all, 2)
      expect(result.length).to eq(8)
      expect(result[0][:player]).to eq(Player.all[0])
      expect(result[0][:player_round]).to eq(Player.all[0].player_rounds[1])
      expect(result[7][:player]).to eq(Player.all[7])
      expect(result[7][:player_round]).to eq(Player.all[7].player_rounds[1])
    end
  end

  describe "#run" do
    it "executes the game and stores the resulting points" do
      @game.run
      expect(@game.player_points[Player.all[0]]).to eq(49)
      expect(@game.player_points[Player.all[1]]).to eq(51)
    end

    it "calculates the payout" do
      @game.run
      expect(@game.payout.owed(Player.all[0], Player.all[1])).to eq(2.55)
      expect(@game.payout.owed(Player.all[1], Player.all[0])).to eq(2.45)
    end
  end
end
