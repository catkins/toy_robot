module ToyRobot
  class Reporter

    def report!(robot)
      return unless robot.on_table?
      position = robot.position
      facing   = robot.facing
      puts "#{position.x},#{position.y},#{facing.name}"
    end
  end
end
