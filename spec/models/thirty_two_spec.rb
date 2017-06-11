require_relative '../../models/thirty_two.rb'
require_relative '../../lib/data_util.rb'

RSpec.describe Course do
  before(:each) do
    DataUtil.load('example')
  end

  describe "#get_payout" do
    it "returns expected payout for 4 putts" do
      payout = ThirtyTwo.all[0].get_payout
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER1'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER3'))).to eq(1)
    end

    it "returns expected payout for 3 putts" do
      payout = ThirtyTwo.all[1].get_payout
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER4'))).to eq(0.5)
    end

    it "returns expected payout for 2 putts" do
      payout = ThirtyTwo.all[2].get_payout
      expect(payout.owed(Player.get('PLAYER3'), Player.get('PLAYER7'))).to eq(0.75)
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER7'))).to eq(0.75)
    end

    it "returns expected payout for 1 putt" do
      payout = ThirtyTwo.all[3].get_payout
      expect(payout.owed(Player.get('PLAYER4'), Player.get('PLAYER8'))).to eq(1.5)
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER8'))).to eq(1.5)
    end
  end

  describe ".get_payout" do
    it "returns expected payout" do
      payout = ThirtyTwo.get_payout
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER1'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER3'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER4'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER3'), Player.get('PLAYER7'))).to eq(0.75)
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER7'))).to eq(0.75)
      expect(payout.owed(Player.get('PLAYER4'), Player.get('PLAYER8'))).to eq(1.5)
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER8'))).to eq(1.5)
    end
  end
end
