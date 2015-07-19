module ToyRobot
  class Direction
    include Virtus.value_object
    include Adamantium

    values do
      attribute :name, String
      attribute :x_difference, Integer, default: 0
      attribute :y_difference, Integer, default: 0
    end

    class << self

      def north
        Direction.new name: 'NORTH', y_difference: 1
      end

      def east
        Direction.new name: 'EAST',  x_difference: 1
      end

      def south
        Direction.new name: 'SOUTH', y_difference: -1
      end

      def west
        Direction.new name: 'WEST',  x_difference: -1
      end

    end
  end
end
