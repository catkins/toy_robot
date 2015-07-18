module ToyRobot
  class Robot
    attr_reader :table, :facing

    def initialize(table:)
      @table  = table
      @facing = :nowhere
    end

    def execute(command, arguments)
      puts "#{command.inspect} => #{arguments}"
    end

  end
end
