require 'test/unit'

class TestLifeGrid < Test::Unit::TestCase

  def test_next_generation
    field = []

    result = next_generation field
  end

  def test_number_of_neighbors 
    field = [[0, 0],[0,1],[1,0]]

    assert_equal 3, number_of_neighbors([1,1], field)
    assert_equal 2, number_of_neighbors([0,0], field)
  end

  def test_cell_with_no_neighbors_dies
    field = [[1,1]]

    assert_equal [], surviving_points(field)
  end

  def test_cells_with_one_neighbor_dies
    field = [[1,1], [0,0]]

    assert_equal [], surviving_points(field)
  end

  def test_cells_with_two_neighbors_live
    field = [[2,0],[1,1],[1,2]]
    expected = [1,1]

    assert_equal expected, surviving_points(field)
  end



# def test_next_potential_birth_cells
#   field = [[0, 0],[0,1],[1,0]]
#   potential_birth_cells field
# end


# def test_new_cell
#   field = []

#   new_cell(field)
# end


  def test_potential_birth_locations 
    field = [[1, 1]]
    expected_cells = [[0,0],[0,1],[0,2],[1,0],[1,2],[2,0],[2,1],[2,2]]

    assert_equal expected_cells, potential_birth_cells(field) 
  end

  #########################################################################

  def next_generation field
    surviving_points(field) + new_points(field)
  end
  
  def surviving_points field
    still_alive = []
    field.each do |point|
      if [2].include? number_of_neighbors(point, field)
        still_alive << point
      end
    end
    still_alive
  end

  def number_of_neighbors point, field
    count = 0
    [-1, 0, 1].each do |x|
      [-1, 0, 1].each do |y|
        #unless x == point[0] && y == point[1]
        if field.include?([point[0] + x, point[1] + y])
          count += 1
        end
      end
    end 
    count
  end

  def new_points field
    field
  end


  def potential_birth_cells field
    potential_points = []
    field.each do |cell|
      [-1, 0, 1].each do |x|
        [-1, 0, 1].each do |y|
          potential_points << [cell[0] + x, cell[1] + y] unless(x==0 && y==0)
        end
      end
    end
    potential_points
  end
end
