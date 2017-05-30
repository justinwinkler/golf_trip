require_relative '../../models/course.rb'
require_relative '../../lib/data_util.rb'

RSpec.describe Course do
  before(:each) do
    DataUtil.load('example')
    @course = Course.get('BH')
  end

  describe "initializion" do
    it "allows access of all supplied params" do
      expect(@course.holes[0].par).to eq(4)
      expect(@course.holes[0].handicap).to eq(5)
      expect(@course.name).to eq('Branson Hills')
      expect(@course.symbol).to eq('BH')
    end
  end

  describe ".to_s" do
    it "returns the course's name" do
      expect(@course.to_s).to eq('Branson Hills')
    end
  end
end

