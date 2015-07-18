require 'thor'

module ToyRobot
  class CLI < Thor

    attr_accessor :input_io

    desc 'simulate', 'begin toy robot simulation'
    option :width,  type: :numeric, desc: 'Width of table',  default: DEFAULT_TABLE_WIDTH
    option :height, type: :numeric, desc: 'Height of table', default: DEFAULT_TABLE_HEIGHT
    def simulate
      @input_io ||= $stdin

      input_io.each_line do |input_line|
        execute_command input_line
      end
    end

    default_task :simulate

    private

    def execute_command(raw_command)
      raw_command = raw_command.strip

      command = extract_command_name raw_command
      args    = extract_command_args raw_command

      puts "#{command.inspect} => #{args}"
    end

    def extract_command_name(line)
      line.split(' ').first.downcase.to_sym
    end

    def extract_command_args(line)
      raw_args = line.split(' ').second

      if raw_args
        raw_args.split ','
      else
        []
      end
    end
  end
end
