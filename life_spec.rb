require 'rspec'
require_relative 'life'

describe "life" do
  describe "#next_generation" do
    it "should do nothing with nothing" do
      expect(next_generation([])).to be_empty
    end

    it "should combine new points with surviving points" do
      allow(self).to receive(:survivors) {[[2,3],[4,4]]}
      allow(self).to receive(:births) {[[1,1],[5,4]]}

      expect(next_generation([])).to match_array([[2,3],[4,4],[1,1],[5,4]])
    end
  end

  describe "#survivors" do
    it "should kill point with no neighbors" do
      ##0#1#2#
      #0 | | #
      #1 |█| #
      #2 | | #
      ########
      living_cells = [[1,1]]
      expect(survivors(living_cells)).to be_empty
    end

    it "should kill points with only one neighbor" do
      ##0#1#2#
      #0█| | #
      #1 |█| #
      #2 | | #
      ########
      living_cells = [[1,1], [0,0]]

      expect(survivors(living_cells)).to be_empty
    end

    it "should persist points with two neighbors" do
      ##0#1#2#
      #0 | |█#
      #1 |█| #
      #2 |█| #
      ########
      living_cells = [[2,0],[1,1],[1,2]]

      expect(survivors(living_cells)).to eq([[1,1]])
    end

    it "should persist points with three neighbors" do
      ##0#1#2#
      #0█| |█#
      #1 |█| #
      #2 |█| #
      ########
      living_cells = [[0,0],[2,0],[1,1],[1,2]]

      expect(survivors(living_cells)).to eq([[1,1]])
    end

    it "should kill points with four neighbors" do
      ##0#1#2#
      #0█| |█#
      #1 |█| #
      #2█| |█#
      ########
      living_cells = [[0,0],[2,0],[1,1],[0,2],[2,2]]

      expect(survivors(living_cells)).to be_empty
    end
  end

  describe "#births" do
    it "should create new points in spaces with exactly three neighbors" do
      ##0#1#2#
      #0 | |█#
      #1 | | #
      #2█| |█#
      ########
      living_cells = [[2,0],[0,2],[2,2]]

      expect(births(living_cells)).to eq([[1,1]])
    end
  end

  describe "#fertile_ground" do
    it "should return a list of neighboring cells for each living cell" do
      # So we don't test the whole world :)
      ##0#1#2#3#
      #0x|x|x| #
      #1x|█|x|x#
      #2x|x|█|x#
      #3 |x|x|x#
      ##########
      living_cells = [[1,1],[2,2]]
      points_worth_testing = [[0,0],[0,1],[0,2],[1,0],[1,2],[1,3],[2,0],
        [2,1],[2,3],[3,1],[3,2],[3,3]]

      expect(fertile_ground(living_cells)).to match_array(points_worth_testing)
    end
  end
end
