LOCAL_OFFSETS = [-1,0,1].product([-1,0,1])
CENTER_OFFSET = [0,0]
NEIGHBOR_OFFSETS = LOCAL_OFFSETS - [CENTER_OFFSET]

def next_generation field
  surviving_points(field) + new_points(field)
end

def surviving_points field
  field.select do |point|
    [2,3].include? number_of_neighbors(point, field)
  end
end

def new_points field
  potential_points(field).select do |point|
    number_of_neighbors(point, field) == 3
  end
end

def number_of_neighbors point, field
  NEIGHBOR_OFFSETS.count do |offset|
    field.include?([point[0] + offset[0], point[1] + offset[1]])
  end
end

def potential_points field
  potential_points = []
  field.each do |point|
    LOCAL_OFFSETS.each do |offset|
      neighbor = [point[0] + offset[0], point[1] + offset[1]]
      potential_points << neighbor unless field.include?(neighbor)
    end
  end
  potential_points.uniq
end

def display_field field, height, width
  height.times do |y|
    width.times do |x|
      if field.include? [x, y]
        print "# "
      else
        print "  "
      end
    end
    print "\n"
  end
  puts "Cell total = #{field.count}"
end

def run_game(field, width=60, height=35, turn_length=0.3)
  clear_code = %x{clear}
  loop do
    print clear_code
    field = next_generation(field)
    display_field(field, width, height)
    sleep turn_length
  end
end
