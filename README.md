[![Build Status](https://travis-ci.org/catkins/toy_robot.svg)](https://travis-ci.org/catkins/toy_robot) [![Coverage Status](https://coveralls.io/repos/catkins/toy_robot/badge.svg?branch=master&service=github)](https://coveralls.io/github/catkins/toy_robot?branch=master) [![Code Climate](https://codeclimate.com/github/catkins/toy_robot/badges/gpa.svg)](https://codeclimate.com/github/catkins/toy_robot)

### Prerequisites

- Ruby 2.1.2 `rbenv install 2.1.2` (or update .ruby-version to your preferred version)
- Bundler `gem install bundler`

### Usage

```bash
# Clone the repo
git clone git@github.com:catkins/toy_robot.git

# Install dependencies
bundle install

# Run the specs
rake

# Run the application providing input from STDIN
# (on OSX and Linux, exit using CTRL + D to send an EOF character)
bin/robot

# Or if you've got a file full of commands handy...
bin/robot < /path/to/command_file.txt
```

### Notes

This is my take on the common Toy Robot coding exercise as created by [Jon Eaves](https://joneaves.wordpress.com/2014/07/21/toy-robot-coding-test/).

My solution was geared towards extensibility and testability. Object composition was used to create small, simple, self-contained objects with clearly defined responsibilities. Particular care was given to ensure that objects and fields that could be immutable, were so.

#### Tools used

- [Thor](http://whatisthor.com/) - The Ruby CLI toolkit by @sferik and @wycats. Used to handle options parsing etc.
- [RSpec](http://rspec.info/) - Defacto standard BDD framework for Ruby
- [Virtus](https://github.com/solnic/virtus) - Used to quickly and declaratively create value types
- [Adamantium](https://github.com/dkubb/adamantium) - Immutability helpers
- [Pry](http://pryrepl.org/) - IRB alternative

### Problem Description

- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement
that would result in the robot falling from the table must be prevented, however further valid movement commands must still
be allowed.

- Create an application that can read in commands of the following form –

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- `PLACE` will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a `PLACE` command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
- `MOVE` will move the toy robot one unit forward in the direction it is currently facing.
- `LEFT` and `RIGHT` will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- `REPORT` will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.
- A robot that is not on the table can choose the ignore the `MOVE`, `LEFT`, `RIGHT` and `REPORT` commands.
- Input can be from a file, or from standard input, as the developer chooses.
- Provide test data to exercise the application.

### Constraints

The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

### Example Input and Output:

a)

Input

```
PLACE 0,0,NORTH
MOVE
REPORT
```

Output

```
0,1,NORTH
```

b)

Input

```
PLACE 0,0,NORTH
LEFT
REPORT
```

Output

```
0,0,WEST
```

c)

Input

```
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
```

Output

```
3,3,NORTH
```
