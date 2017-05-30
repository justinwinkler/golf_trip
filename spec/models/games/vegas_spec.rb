require_relative '../../../lib/data_util.rb'
require_relative '../../../models/games/vegas.rb'

RSpec.describe Vegas do
  before(:each) do
    DataUtil.load('example')
    @vegas = nil
  end

  def vegas
    return @vegas if @vegas
    @vegas = Vegas.new(@team_matrix, 1)
    return @vegas
  end
end
