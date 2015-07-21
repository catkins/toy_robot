RSpec.describe ToyRobot::Compass do
  subject(:compass) { described_class.new }

  it { is_expected.to respond_to :bearing }
  it { is_expected.to respond_to :bearing= }
  it { is_expected.to respond_to :turn_right! }

  describe '#bearing' do
    it 'is initially pointing north' do
      expect(compass.bearing).to eq ToyRobot::Direction::NORTH
    end

    it 'returns the current bearing' do
      compass.bearing = ToyRobot::Direction::WEST
      expect(compass.bearing).to eq ToyRobot::Direction::WEST

      compass.bearing = ToyRobot::Direction::EAST
      expect(compass.bearing).to eq ToyRobot::Direction::EAST
    end
  end

  describe '#includes_direction?' do
    subject(:result) { compass.includes_direction? direction }

    context 'with valid compass bearing' do
      let(:direction) { ToyRobot::Direction::EAST }

      it { is_expected.to be true }
    end

    context 'with invalid compass bearing' do
      let(:direction) { ToyRobot::Direction.new name: 'Starward' }

      it { is_expected.to be false }
    end
  end

  describe '#turn_left!' do
    it { is_expected.to respond_to :turn_left! }

    before { compass.bearing = ToyRobot::Direction::NORTH }

    it 'one call turns the compass 90 degrees to the left' do
      compass.turn_left!
      expect(compass.bearing).to eq ToyRobot::Direction::WEST
    end

    it 'two calls turns the compass 180 degrees to the left' do
      2.times { compass.turn_left! }
      expect(compass.bearing).to eq ToyRobot::Direction::SOUTH
    end

    it 'three calls turns the compass 90 degrees to the left' do
      3.times { compass.turn_left! }
      expect(compass.bearing).to eq ToyRobot::Direction::EAST
    end

    it 'four calls turns the compass a full circle' do
      4.times { compass.turn_left! }
      expect(compass.bearing).to eq ToyRobot::Direction::NORTH
    end
  end

  describe '#turn_right!' do
    it { is_expected.to respond_to :turn_right! }

    before { compass.bearing = ToyRobot::Direction::NORTH }

    it 'one call turns the compass 90 degrees to the right' do
      compass.turn_right!
      expect(compass.bearing).to eq ToyRobot::Direction::EAST
    end

    it 'two calls turns the compass 180 degrees to the right' do
      2.times { compass.turn_right! }
      expect(compass.bearing).to eq ToyRobot::Direction::SOUTH
    end

    it 'three calls turns the compass 90 degrees to the right' do
      3.times { compass.turn_right! }
      expect(compass.bearing).to eq ToyRobot::Direction::WEST
    end

    it 'four calls turns the compass a full circle' do
      4.times { compass.turn_right! }
      expect(compass.bearing).to eq ToyRobot::Direction::NORTH
    end
  end
end
