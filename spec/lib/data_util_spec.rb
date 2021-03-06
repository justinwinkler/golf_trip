require_relative '../../lib/data_util.rb'

RSpec.describe DataUtil, ".team_matrix" do
  it "produces expected result for 4-some that cycles partners every hole" do
    result = DataUtil.team_matrix [1,2,3,4], 1, 2
    expect(result).to eq([
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]]])
  end

  it "produces expected result for 4-some that cycles partners @ 3 holes" do
    result = DataUtil.team_matrix [1,2,3,4], 3, 2
    expect(result).to eq([
      [[1,2], [3,4]],
      [[1,2], [3,4]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,3], [2,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,4], [2,3]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,2], [3,4]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,3], [2,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,4], [2,3]],
      [[1,4], [2,3]]])
  end

  it "produces expected result for 4-some that cycles partners @ 3 holes" do
    result = DataUtil.team_matrix [1,2,3,4], 3, 2
    expect(result).to eq([
      [[1,2], [3,4]],
      [[1,2], [3,4]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,3], [2,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,4], [2,3]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,2], [3,4]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,3], [2,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,4], [2,3]],
      [[1,4], [2,3]]])
  end

  it "produces expected result for 4-some that cycles partners every hole" do
    result = DataUtil.team_matrix [1,2,3,4], 1, 2
    expect(result).to eq([
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]],
      [[1,2], [3,4]],
      [[1,3], [2,4]],
      [[1,4], [2,3]]])
  end

  it "produces expected result for 8-some that cycles partners every hole" do
    result = DataUtil.team_matrix [1,2,3,4,5,6,7,8], 1, 2
    expect(result).to eq([
      [[1,2], [3,4], [5,6], [7,8]],
      [[1,3], [2,4], [5,7], [6,8]],
      [[1,4], [2,3], [5,8], [6,7]],
      [[1,5], [2,6], [3,7], [4,8]],
      [[1,6], [2,5], [3,8], [4,7]],
      [[1,7], [2,8], [3,5], [4,6]],
      [[1,8], [2,7], [3,6], [4,5]],
      [[1,2], [3,4], [5,6], [7,8]],
      [[1,3], [2,4], [5,7], [6,8]],
      [[1,4], [2,3], [5,8], [6,7]],
      [[1,5], [2,6], [3,7], [4,8]],
      [[1,6], [2,5], [3,8], [4,7]],
      [[1,7], [2,8], [3,5], [4,6]],
      [[1,8], [2,7], [3,6], [4,5]],
      [[1,2], [3,4], [5,6], [7,8]],
      [[1,3], [2,4], [5,7], [6,8]],
      [[1,4], [2,3], [5,8], [6,7]],
      [[1,5], [2,6], [3,7], [4,8]]])
  end

  it "produces expected result for 8-some in teams of 4 for entire round" do
    result = DataUtil.team_matrix [1,2,3,4,5,6,7,8], 18, 4
    expect(result).to eq([
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]],
      [[1,2,3,4], [5,6,7,8]]])
  end
end
