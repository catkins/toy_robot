module ToyRobot
  class Robot
    attr_reader :table, :compass

    def initialize(table:, compass: Compass.new)
      @table   = table
      @compass = compass
    end

    def execute(command, arguments)
      puts "#{command.inspect} => #{arguments}"
    end

    def facing
      compass.bearing
    end

  end
end
