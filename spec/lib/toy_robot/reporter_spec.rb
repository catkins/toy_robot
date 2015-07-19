RSpec.describe ToyRobot::Reporter do

  it { is_expected.to respond_to :report! }

  describe '#report!' do
    let(:reporter) { described_class.new }
    let(:robot)    { instance_double('ToyRobot::Robot') }
    let(:output)   { capture(:stdout) { reporter.report!(robot) } }

    context 'when robot is off the table' do
      before { allow(robot).to receive(:on_table?).and_return false }

      it 'does not output anything' do
        expect(output).to be_empty
      end
    end

    context 'when robot is on the table' do
      let(:direction) { ToyRobot::Direction.north }
      let(:position)  { ToyRobot::Point.new x: 2, y: 3 }

      before do
        allow(robot).to receive(:on_table?).and_return true
        allow(robot).to receive(:facing).and_return direction
        allow(robot).to receive(:position).and_return position
      end

      it 'outputs the current coordinates' do
        expect(output).to eq "2,3,NORTH\n"
      end
    end
  end
end
