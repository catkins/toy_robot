module ToyRobot
  class Compass
    def initialize
      @directions = Direction::COMPASS_DIRECTIONS.dup
    end

    def turn_left!
      @directions.rotate!(-1)
    end

    def turn_right!
      @directions.rotate!(1)
    end

    def bearing
      @directions.first
    end

    def bearing=(new_bearing)
      return unless has_direction?(new_bearing)

      @directions.rotate! @directions.index new_bearing
    end

    def has_direction?(direction)
      @directions.include? direction
    end
  end
end
