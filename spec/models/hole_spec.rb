require_relative '../../lib/data_util.rb'
require_relative '../../models/hole.rb'

RSpec.describe Hole do
  before(:each) do
    DataUtil.load('example')
    @hole = Course.get('OK').holes[0]
  end

  describe "initializion" do
    it "allows access of all supplied params" do
      expect(@hole.par).to eq(4)
      expect(@hole.handicap).to eq(3)
    end
  end
end
