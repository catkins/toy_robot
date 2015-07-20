module ToyRobot
  class Reporter

    def report!(robot)
      return unless robot.on_table?

      position = robot.position
      facing   = robot.facing

      $stdout.puts "#{position.x},#{position.y},#{facing.name}"
      $stdout.flush
    end
  end
end
