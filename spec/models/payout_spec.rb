require_relative '../../models/payout.rb'
require_relative '../../lib/data_util.rb'

RSpec.describe Payout do
  before(:each) do
    DataUtil.load('example')
    @players = Player.all
    @payout = Payout.new(@players)
  end

  describe 'initializion' do
    it 'allows access of all supplied params' do
      expect(@payout.players).to eq(@players)
    end
  end

  describe '#owed' do
    it 'defaults money owed to 0' do
      entries = 0
      Player.all.each do |payer|
        Player.all.reverse.each do |payee|
          if payer != payee
            entries += 1
            expect(@payout.owed(payer, payee)).to eq(0)
          end
        end
      end
      expect(entries).to eq(56)
    end
  end

  describe '#owes' do
    it 'adds the amount owed' do
      payer = Player.all[0]
      payee = Player.all[1]
      amount = 10.05
      @payout.owes(payer, payee, amount)
      expect(@payout.owed(payer, payee)).to eq(amount)
      expect(@payout.owed(payee, payer)).to eq(0)
    end
  end

  describe '#+' do
    it 'adds the payouts' do
      payer = Player.all[0]
      payee = Player.all[1]
      amount1 = 10
      amount2 = 11
      @payout.owes(payer, payee, amount1)
      payout2 = Payout.new(@players)
      payout2.owes(payer, payee, amount2)
      total_payout = @payout + payout2
      expect(total_payout.owed(payer, payee)).to eq(21)
    end
  end

  describe '#add_points' do
    it 'adds the points' do
      points = {}
      points[Player.all[0]] = 4
      points[Player.all[1]] = 10
      points[Player.all[2]] = 0
      points[Player.all[3]] = 0
      points[Player.all[4]] = 0
      points[Player.all[5]] = 0
      points[Player.all[6]] = 0
      points[Player.all[7]] = 0
      @payout.add_points(points, 0.5)
      expect(@payout.owed(Player.all[0], Player.all[1])).to eq(5)
      expect(@payout.owed(Player.all[0], Player.all[2])).to eq(0)
      expect(@payout.owed(Player.all[1], Player.all[0])).to eq(2)
      expect(@payout.owed(Player.all[1], Player.all[2])).to eq(0)
      expect(@payout.owed(Player.all[2], Player.all[0])).to eq(2)
      expect(@payout.owed(Player.all[2], Player.all[1])).to eq(5)
    end
  end
end
