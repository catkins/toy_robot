module ToyRobot
  class Executor

    AVAILABLE_COMMANDS = %i(left right move place report).freeze

    attr_reader :robot

    def initialize(robot)
      @robot = robot
    end

    def call(command, args)
      return unless AVAILABLE_COMMANDS.include? command

      if args.any?
        send command, *args
      else
        send command
      end
    end

    private

    def place(x, y, direction)
      position  = Point.new x: x, y: y
      direction = Direction.by_name direction
      robot.place position, direction
    end

    %i(left right move report).each do |command|
      define_method(command) do
        robot.public_send command
      end
    end
  end
end
