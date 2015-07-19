require 'spec_helper'

RSpec.describe ToyRobot::Robot do

  let(:table)   { ToyRobot::Table.new width: 5, height: 5 }
  let(:compass) { ToyRobot::Compass.new }

  subject(:robot) { described_class.new(table: table, compass: compass) }

  it { is_expected.not_to be_nil }
  it { is_expected.to respond_to :compass }

  describe '#facing' do
    it { is_expected.to respond_to :facing }

    it 'begins facing north' do
      expect(robot.facing).to eq ToyRobot::Direction.north
    end

    it "delegates to the robot's compass" do
      expected_direction = ToyRobot::Direction.new name: 'Onward and upward'
      expect(compass).to receive(:bearing).and_return expected_direction

      result = robot.facing
      expect(result).to eq(expected_direction)
    end
  end

  describe '#position' do
    context 'robot has not yet been placed on table' do
      its(:position) { is_expected.to be_nil }
    end

    context 'robot has been placed on a valid position on table' do
      let(:valid_point) { ToyRobot::Point.new x: 3, y: 2 }
      before { robot.place valid_point, ToyRobot::Direction.north }

      its(:position) { is_expected.to eq valid_point }
    end
  end

  describe '#on_table?' do
    context 'robot has not yet been placed on table' do
      its(:on_table?) { is_expected.to be false }
    end

    context 'robot has been placed on a valid position on table' do
      let(:valid_point) { ToyRobot::Point.new x: 3, y: 2 }
      before { robot.place valid_point, ToyRobot::Direction.north }

      its(:on_table?) { is_expected.to be true }
    end
  end

  describe '#place' do
    let(:new_point)     { ToyRobot::Point.new x: 3, y: 2 }
    let(:new_direction) { ToyRobot::Direction.east }

    context 'with a valid point and direction' do

      it "updates robot's position" do
        expect {
          robot.place(new_point, new_direction)
        }.to change(robot, :position).from(nil).to(ToyRobot::Point.new x: 3, y: 2)
      end

      it "updates robot's facing" do
        old_direction = ToyRobot::Direction.north
        expect {
          robot.place(new_point, new_direction)
        }.to change(robot, :facing).from(old_direction).to(new_direction)
      end
    end

    context 'with an invalid (off the table) point' do
      let(:new_point)     { ToyRobot::Point.new x: 5, y: 6 }
      let(:new_direction) { ToyRobot::Direction.east }

      it "does not change robot's position" do
        expect {
          robot.place(new_point, new_direction)
        }.not_to change(robot, :position)
      end

      it "does not change robot's facing" do
        old_direction = ToyRobot::Direction.north
        expect {
          robot.place(new_point, new_direction)
        }.not_to change(robot, :facing)
      end
    end

    context 'with an invalid direction' do
      let(:new_point)     { ToyRobot::Point.new x: 3, y: 2 }
      let(:new_direction) { ToyRobot::Direction.new name: 'downside up' }

      it "does not change robot's position" do
        expect {
          robot.place(new_point, new_direction)
        }.not_to change(robot, :position)
      end

      it "does not change robot's facing" do
        old_direction = ToyRobot::Direction.north
        expect {
          robot.place(new_point, new_direction)
        }.not_to change(robot, :facing)
      end
    end
  end

  describe '#move' do
    it { is_expected.to respond_to :move }

    context 'before robot is placed on table' do
      it "does not change robot's position" do
        expect {
          robot.move
        }.not_to change(robot, :position)
      end
    end

    context 'when robot is not on edge of table' do
      let(:starting_point) { ToyRobot::Point.new x: 1, y: 1 }
      before { robot.place starting_point, ToyRobot::Direction.north }

      it 'updates position' do
        expect { robot.move } .to change(robot, :position)
          .from(starting_point).to(ToyRobot::Point.new x: 1, y: 2)
      end
    end

    context 'when robot is on edge of table and facing the abyss' do
      let(:starting_point) { ToyRobot::Point.new x: 0, y: 0 }
      let(:direction) { ToyRobot::Direction.south }
      before { robot.place starting_point, direction }

      it "does not change robot's position" do
        expect {
          robot.place(starting_point, direction)
        }.not_to change(robot, :position)
      end
    end
  end

  describe '#execute' do
    it { is_expected.to respond_to :execute }

  end

end

