require 'thor'

module ToyRobot
  class CLI < Thor

    attr_accessor :input_io
    attr_reader :robot, :executor

    desc 'simulate', 'begin toy robot simulation'
    option :width,  type: :numeric, desc: 'Width of table',  default: DEFAULT_TABLE_WIDTH
    option :height, type: :numeric, desc: 'Height of table', default: DEFAULT_TABLE_HEIGHT
    def simulate
      @input_io ||= $stdin

      @robot    = build_robot!
      @executor = Executor.new robot

      input_io.each_line do |input_line|
        execute_command input_line
      end
    end

    default_task :simulate

    private

    def build_robot!
      width  = options[:width]
      height = options[:height]
      table  = Table.new width: width, height: height

      fail 'Invalid dimensions for tabletop' unless table.valid?

      Robot.new table: table
    end

    def execute_command(raw_command)
      raw_command = raw_command.strip

      return if raw_command.blank?

      command = extract_command_name raw_command
      args    = extract_command_args raw_command

      executor.call command, args
    end

    def extract_command_name(line)
      line.split(' ').first.downcase.to_sym
    end

    def extract_command_args(line)
      raw_args = line.split(' ').second

      if raw_args.present?
        raw_args.split ','
      else
        []
      end
    end

  end
end
