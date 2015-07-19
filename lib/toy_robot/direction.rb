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
        Direction.new name: 'north', y_difference: 1
      end

      def east
        Direction.new name: 'east',  x_difference: 1
      end

      def south
        Direction.new name: 'south', y_difference: -1
      end

      def west
        Direction.new name: 'west',  x_difference: -1
      end

    end
  end
end
