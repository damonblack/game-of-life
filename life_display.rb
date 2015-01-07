WIDTH, HEIGHT = 60, 35
FIELD1 = [[24,21],[24,22],[24,23],[22,23],[22,21],[20,20],[21,20],[15,14],[16,14],[16,16],[9,26],[10,26],[10,27],[11,26]]
FIELD2 = [[24,21],[24,22],[24,23],[22,23],[22,21],[20,20],[21,20],[5,5],[3,3],[4,4],[3,2],[5,4],[2,2],[15,14],[16,14],[16,16],[15,17]]

def next_generation field
  surviving_points(field) + new_points(field)
end

def surviving_points field
  still_alive = []
  field.each do |point|
    if [2,3].include? number_of_neighbors(point, field) 
      still_alive << point
    end
  end
  still_alive
end

def new_points field
  births = []
  potential_points(field).each do |point|
    births << point if number_of_neighbors(point, field) == 3
  end
  births
end

def number_of_neighbors point, field
  count = 0
  [-1, 0, 1].each do |x|
    [-1, 0, 1].each do |y|
      unless(x == 0 && y == 0)
        if field.include?([point[0] + x, point[1] + y])
          count += 1
        end
      end
    end
  end 
  count
end

def potential_points field
  potential_points = []
  field.each do |point|
    [-1, 0, 1].each do |x|
      [-1, 0, 1].each do |y|
        neighbor = [point[0] + x, point[1] + y]
        unless field.include?(neighbor)
          potential_points << neighbor
        end
      end
    end
  end
  potential_points.uniq
end

def display_field field
  HEIGHT.times do |y|
    WIDTH.times do |x|
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

field = FIELD1 
clear_code = %x{clear}

loop do
  print clear_code
  field = next_generation field
  display_field field
  sleep 0.5
end
