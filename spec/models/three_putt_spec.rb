require_relative '../../models/three_putt.rb'
require_relative '../../lib/data_util.rb'

RSpec.describe ThreePutt do
  before(:each) do
    DataUtil.load('example')
  end

  describe "#get_payout" do
    it "returns expected payout for 4some" do
      payout = ThreePutt.all[0].get_payout
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER1'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER3'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER4'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER5'))).to eq(0.0)
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER6'))).to eq(0.0)
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER7'))).to eq(0.0)
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER8'))).to eq(0.0)
    end

    it "returns expected payout for 8some" do
      payout = ThreePutt.all[1].get_payout
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER1'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER3'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER4'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER5'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER6'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER7'))).to eq(0.5)
    end
  end

  describe ".get_payout" do
    it "returns expected payout" do
      payout = ThreePutt.get_payout
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER1'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER3'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER2'), Player.get('PLAYER4'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER1'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER3'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER4'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER5'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER6'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER7'))).to eq(0.5)
    end
  end
end
