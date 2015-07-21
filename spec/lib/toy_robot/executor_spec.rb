RSpec.describe ToyRobot::Executor do
  let(:robot) { instance_double 'ToyRobot::Robot' }
  subject(:executor) { described_class.new(robot) }

  it { is_expected.to respond_to :call }
  it { is_expected.to respond_to :robot }

  describe '#robot' do
    it 'is the robot that was passed in to constructor' do
      expect(subject.robot).to eq robot
    end
  end

  describe '#call' do
    context 'unknown commands' do
      it 'does nothing' do
        expect { executor.call :garbage, [] }.not_to raise_error
      end
    end

    context 'place' do
      let(:expected_position) { ToyRobot::Point.new x: 2, y: 4 }
      let(:expected_direction) { ToyRobot::Direction.by_name 'NORTH' }

      it 'delegates to Robot#place' do
        expect(robot).to receive(:place)
          .with(expected_position, expected_direction)

        executor.call :place, %w(2 4 NORTH)
      end
    end

    %w(left right move report).each do |command|
      context(command) do
        it "delegates to Robot##{command}" do
          expect(robot).to receive(command.to_sym)
          executor.call command.to_sym, []
        end
      end
    end
  end
end
