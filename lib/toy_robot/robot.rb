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
      if table.inside_bounds?(point) && compass.has_direction?(direction)
        @position        = point
        @compass.bearing = direction
      end

      nil
    end

    def move
      return unless on_table?

      new_position = @position.step_in_direction(@compass.bearing)

      if valid_position? new_position
        @position = new_position
      end

      nil
    end

    def report
      reporter.report! self

      nil
    end

    def on_table?
      position.present?
    end

    private

    def valid_position?(point)
      @table.inside_bounds?(point)
    end

  end
end
