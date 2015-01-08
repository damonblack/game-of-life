LOCAL_OFFSETS = [-1,0,1].product([-1,0,1])
CENTER_OFFSET = [0,0]
NEIGHBOR_OFFSETS = LOCAL_OFFSETS - [CENTER_OFFSET]

def next_generation living_cells
  survivors(living_cells) + births(living_cells)
end

def survivors living_cells
  living_cells.select do |point|
    [2,3].include? number_of_neighbors(point, living_cells)
  end
end

def births living_cells
  fertile_ground(living_cells).select do |point|
    number_of_neighbors(point, living_cells) == 3
  end
end

def number_of_neighbors point, living_cells
  NEIGHBOR_OFFSETS.count do |offset|
    living_cells.include?([point[0] + offset[0], point[1] + offset[1]])
  end
end

def fertile_ground living_cells
  living_cells.flat_map do |point|
    LOCAL_OFFSETS.map do |offset|
      neighbor = [point[0] + offset[0], point[1] + offset[1]]
      neighbor unless living_cells.include?(neighbor)
    end
  end.compact.uniq
end

def display_living_cells living_cells, width, height
  height.times do |y|
    width.times do |x|
      if living_cells.include? [x, y]
        print "# "
      else
        print "  "
      end
    end
    print "\n"
  end
  print "Cell total = #{living_cells.count}"
end

def run_game(living_cells, width=40, height=35, turn_length=0.5)
  loop do
    system('clear')
    display_living_cells(living_cells, width, height)
    living_cells = next_generation(living_cells)
    sleep turn_length
  end
end
