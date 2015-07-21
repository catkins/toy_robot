require 'spec_helper'

RSpec.describe ToyRobot::Robot do
  let(:table)    { ToyRobot::Table.new width: 5, height: 5 }
  let(:compass)  { ToyRobot::Compass.new }
  let(:reporter) { instance_double('ToyRobot::Reporter') }

  subject(:robot) { described_class.new(table: table, compass: compass, reporter: reporter) }

  it { is_expected.not_to be_nil }
  it { is_expected.to respond_to :compass }
  it { is_expected.to respond_to :reporter }

  describe '#facing' do
    it { is_expected.to respond_to :facing }

    it 'begins facing north' do
      expect(robot.facing).to eq ToyRobot::Direction::NORTH
    end

    it "delegates to the robot's compass" do
      expected_direction = ToyRobot::Direction.new name: 'Onward and upward'
      expect(compass).to receive(:bearing).and_return expected_direction

      result = robot.facing
      expect(result).to eq(expected_direction)
    end
  end

  describe '#report' do
    it { is_expected.to respond_to :report }

    before { allow(reporter).to receive(:report!) }

    it "delegates reporting to it's reporter" do
      robot.report
      expect(reporter).to have_received(:report!).with(robot)
    end

    it 'returns nil as it is a command method' do
      expect(robot.report).to be_nil
    end
  end

  describe '#position' do
    context 'robot has not yet been placed on table' do
      its(:position) { is_expected.to be_nil }
    end

    context 'robot has been placed on a valid position on table' do
      let(:valid_point) { ToyRobot::Point.new x: 3, y: 2 }
      before { robot.place valid_point, ToyRobot::Direction::NORTH }

      its(:position) { is_expected.to eq valid_point }
    end
  end

  describe '#on_table?' do
    context 'robot has not yet been placed on table' do
      its(:on_table?) { is_expected.to be false }
    end

    context 'robot has been placed on a valid position on table' do
      let(:valid_point) { ToyRobot::Point.new x: 3, y: 2 }
      before { robot.place valid_point, ToyRobot::Direction::NORTH }

      its(:on_table?) { is_expected.to be true }
    end
  end

  describe '#left' do
    it "delegates to the robot's compass" do
      expect(compass).to receive(:turn_left!)
      robot.left
    end

    it 'returns nil as it is a command method' do
      expect(robot.left).to be_nil
    end

    it 'updates robots `facing` to be 90 degrees to the left' do
      old_direction = robot.facing
      new_direction = ToyRobot::Direction::WEST
      expect { robot.left }.to change(robot, :facing).from(old_direction).to(new_direction)
    end
  end

  describe '#right' do
    it "delegates to the robot's compass" do
      expect(compass).to receive(:turn_right!)
      robot.right
    end

    it 'returns nil as it is a command method' do
      expect(robot.right).to be_nil
    end

    it 'updates robots `facing` to be 90 degrees to the right' do
      old_direction = robot.facing
      new_direction = ToyRobot::Direction::EAST
      expect { robot.right }.to change(robot, :facing).from(old_direction).to(new_direction)
    end
  end

  describe '#place' do
    let(:new_point)     { ToyRobot::Point.new x: 3, y: 2 }
    let(:new_direction) { ToyRobot::Direction::EAST }

    context 'with a valid point and direction' do
      it "updates robot's position" do
        expect do
          robot.place(new_point, new_direction)
        end.to change(robot, :position).from(nil).to(ToyRobot::Point.new x: 3, y: 2)
      end

      it "updates robot's facing" do
        old_direction = ToyRobot::Direction::NORTH
        expect do
          robot.place(new_point, new_direction)
        end.to change(robot, :facing).from(old_direction).to(new_direction)
      end
    end

    context 'with an invalid (off the table) point' do
      let(:new_point)     { ToyRobot::Point.new x: 5, y: 6 }
      let(:new_direction) { ToyRobot::Direction::EAST }

      it "does not change robot's position" do
        expect do
          robot.place(new_point, new_direction)
        end.not_to change(robot, :position)
      end

      it "does not change robot's facing" do
        old_direction = ToyRobot::Direction::NORTH
        expect do
          robot.place(new_point, new_direction)
        end.not_to change(robot, :facing)
      end
    end

    context 'with an invalid direction' do
      let(:new_point)     { ToyRobot::Point.new x: 3, y: 2 }
      let(:new_direction) { ToyRobot::Direction.new name: 'downside up' }

      it "does not change robot's position" do
        expect do
          robot.place(new_point, new_direction)
        end.not_to change(robot, :position)
      end

      it "does not change robot's facing" do
        old_direction = ToyRobot::Direction::NORTH
        expect do
          robot.place(new_point, new_direction)
        end.not_to change(robot, :facing)
      end
    end
  end

  describe '#move' do
    it { is_expected.to respond_to :move }

    context 'before robot is placed on table' do
      it "does not change robot's position" do
        expect do
          robot.move
        end.not_to change(robot, :position)
      end

      it 'returns nil as it is a command method' do
        expect(robot.move).to be_nil
      end
    end

    context 'when robot is not on edge of table' do
      let(:starting_point) { ToyRobot::Point.new x: 1, y: 1 }
      before { robot.place starting_point, ToyRobot::Direction::NORTH }

      it 'updates position' do
        expect { robot.move } .to change(robot, :position)
          .from(starting_point).to(ToyRobot::Point.new x: 1, y: 2)
      end

      it 'returns nil as it is a command method' do
        expect(robot.move).to be_nil
      end
    end

    context 'when robot is on edge of table and facing the abyss' do
      let(:starting_point) { ToyRobot::Point.new x: 0, y: 0 }
      let(:direction) { ToyRobot::Direction::SOUTH }
      before { robot.place starting_point, direction }

      it "does not change robot's position" do
        expect do
          robot.place(starting_point, direction)
        end.not_to change(robot, :position)
      end

      it 'returns nil as it is a command method' do
        expect(robot.place(starting_point, direction)).to be_nil
      end
    end
  end
end
