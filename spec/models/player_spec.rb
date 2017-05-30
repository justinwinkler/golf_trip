require_relative '../../lib/data_util.rb'
require_relative '../../models/player.rb'

RSpec.describe Player do
  before(:each) do
    DataUtil.load('example')
    @player = Player.get('PLAYER1')
  end

  describe "initializion" do
    it "allows access of all supplied params" do
      expect(@player.name).to eq('Player 1')
      expect(@player.symbol).to eq('PLAYER1')
    end
  end

  describe "handicap rounding" do
    it "rounds .4 handicaps on odds down" do
      player = Player.new('test', 'TEST', 5.4)
      expect(player.applied_handicap).to eq(5)
    end

    it "rounds .4 handicaps on evens up" do
      player = Player.new('test', 'TEST', 6.4)
      expect(player.applied_handicap).to eq(6)
    end

    it "rounds .5 handicaps on odds up" do
      player = Player.new('test', 'TEST', 5.5)
      expect(player.applied_handicap).to eq(6)
    end

    it "rounds .5 handicaps on evens up" do
      player = Player.new('test', 'TEST', 6.5)
      expect(player.applied_handicap).to eq(7)
    end
  end

  describe ".to_s" do
    it "returns the player's name" do
      expect(@player.to_s).to eq('Player 1')
    end
  end
end
