# Only include extensions we actually use to prevent super slow startup time
require 'active_support/core_ext/array/access'
require 'active_support/core_ext/range/include_range'
require 'active_support/core_ext/object/blank'

require 'virtus'
require 'adamantium'

module ToyRobot
  DEFAULT_TABLE_WIDTH  = 5
  DEFAULT_TABLE_HEIGHT = 5
end

require 'toy_robot/table'
require 'toy_robot/reporter'
require 'toy_robot/point'
require 'toy_robot/direction'
require 'toy_robot/compass'
require 'toy_robot/robot'
require 'toy_robot/executor'
require 'toy_robot/cli'
