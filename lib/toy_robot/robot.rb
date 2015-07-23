module ToyRobot
  class Robot
    attr_reader :table, :compass, :position, :reporter

    def initialize(table:, compass: Compass.new, reporter: Reporter.new)
      @table    = table
      @compass  = compass
      @reporter = reporter
      @position = nil
    end

    def facing
      compass.bearing
    end

    def left
      @compass.turn_left!

      nil
    end

    def right
      @compass.turn_right!

      nil
    end

    def place(point, direction)
      if valid_position?(point) && compass.includes_direction?(direction)
        @position        = point
        @compass.bearing = direction
      end

      nil
    end

    def move
      return unless on_table?

      @position = point_in_front if valid_position? point_in_front

      nil
    end

    def place_object
      @table.place_object! point_in_front
    end

    def report
      reporter.report! self

      nil
    end

    def on_table?
      position.present?
    end

    private

    def point_in_front
      @position.step_in_direction(@compass.bearing)
    end

    def valid_position?(point)
      @table.position_is_vacant?(point)
    end
  end
end
