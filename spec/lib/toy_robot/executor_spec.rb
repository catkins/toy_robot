RSpec.describe ToyRobot::Executor do

  let(:robot) { instance_double 'ToyRobot::Roboy' }
  subject(:executor) { described_class.new(robot) }

  it { is_expected.to respond_to :call }
  it { is_expected.to respond_to :robot }

  describe '#robot' do
    it "is the robot that was passed in to constructor" do
      expect(subject.robot).to eq robot
    end
  end

  describe '#call' do
    context 'left'
    context 'right'
    context 'move'
    context 'place'
    context 'report'
  end

end
