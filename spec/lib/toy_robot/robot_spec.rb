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

  describe '#execute' do
    it { is_expected.to respond_to :execute }

  end

end

