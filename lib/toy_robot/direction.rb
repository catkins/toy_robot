module ToyRobot
  class Direction
    include Virtus.value_object
    include Adamantium

    values do
      attribute :name, String
      attribute :x_difference, Integer, default: 0
      attribute :y_difference, Integer, default: 0
    end


    NORTH = new(name: 'NORTH', y_difference: 1)
    EAST  = new(name: 'EAST',  x_difference: 1)
    SOUTH = new(name: 'SOUTH', y_difference: -1)
    WEST  = new(name: 'WEST',  x_difference: -1)

    COMPASS_DIRECTIONS = [ NORTH, EAST, SOUTH, WEST ].freeze

    class << self

      def by_name(name)
        COMPASS_DIRECTIONS.find { |direction| direction.name == name }
      end

    end
  end
end
