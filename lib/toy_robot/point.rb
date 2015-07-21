module ToyRobot
  class Point
    include Virtus.value_object
    include Adamantium

    values do
      attribute :x, Integer
      attribute :y, Integer
    end

    def step_in_direction(direction)
      new_x = x + direction.x_difference
      new_y = y + direction.y_difference

      Point.new x: new_x, y: new_y
    end
  end
end
