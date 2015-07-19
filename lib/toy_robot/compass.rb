module ToyRobot
  class Compass

    def initialize
      @directions = [
        Direction.north,
        Direction.east,
        Direction.south,
        Direction.west
      ]
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
      return unless @directions.include? new_bearing

      @directions.rotate! @directions.index new_bearing
    end
  end
end
