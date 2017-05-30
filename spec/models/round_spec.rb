require_relative '../../lib/data_util.rb'
require_relative '../../models/round.rb'

RSpec.describe Round do
  before(:each) do
    DataUtil.load('example')
    @round = Round.get(1)
  end

  describe "initializion" do
    it "allows access of all supplied params" do
      expect(@round.number).to eq(1)
      expect(@round.course).to eq(Course.get('OK'))
    end
  end
end

