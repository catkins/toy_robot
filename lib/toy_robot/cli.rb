require 'thor'

module ToyRobot
  class CLI < Thor


    desc 'simulate', 'begin toy robot simulation'
    option :width,  type: :numeric, desc: 'Width of table',  default: DEFAULT_TABLE_WIDTH
    option :height, type: :numeric, desc: 'Height of table', default: DEFAULT_TABLE_HEIGHT
    def simulate

    end

    default_task :simulate

  end
end
