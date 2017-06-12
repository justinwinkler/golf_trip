require_relative '../../models/nastie.rb'
require_relative '../../lib/data_util.rb'

RSpec.describe Nastie do
  before(:each) do
    DataUtil.load('example')
  end

  describe "#get_payout" do
    it "returns expected payout for 4some" do
      payout = Nastie.all[0].get_payout
      expect(payout.owed(Player.get('PLAYER1'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER3'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER4'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER2'))).to eq(0.0)
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER2'))).to eq(0.0)
      expect(payout.owed(Player.get('PLAYER7'), Player.get('PLAYER2'))).to eq(0.0)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER2'))).to eq(0.0)
    end

    it "returns expected payout for 8some" do
      payout = Nastie.all[1].get_payout
      expect(payout.owed(Player.get('PLAYER1'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER3'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER4'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER7'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER2'))).to eq(0.5)
    end
  end

  describe ".get_payout" do
    it "returns expected payout" do
      payout = Nastie.get_payout
      expect(payout.owed(Player.get('PLAYER1'), Player.get('PLAYER2'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER3'), Player.get('PLAYER2'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER4'), Player.get('PLAYER2'))).to eq(1)
      expect(payout.owed(Player.get('PLAYER5'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER6'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER7'), Player.get('PLAYER2'))).to eq(0.5)
      expect(payout.owed(Player.get('PLAYER8'), Player.get('PLAYER2'))).to eq(0.5)
    end
  end
end

