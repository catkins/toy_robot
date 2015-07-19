RSpec.describe ToyRobot::Compass do

  subject(:compass) { described_class.new() }

  it { is_expected.to respond_to :bearing }
  it { is_expected.to respond_to :bearing= }
  it { is_expected.to respond_to :turn_right! }

  describe "#bearing" do
    it "is initially pointing north" do
      expect(compass.bearing).to eq ToyRobot::Direction.north
    end

    it "returns the current bearing" do
      compass.bearing = ToyRobot::Direction.west
      expect(compass.bearing).to eq ToyRobot::Direction.west

      compass.bearing = ToyRobot::Direction.east
      expect(compass.bearing).to eq ToyRobot::Direction.east
    end
  end

  describe '#has_direction?' do
    subject(:result) { compass.has_direction? direction }

    context 'with valid compass bearing' do
      let(:direction) { ToyRobot::Direction.east }

      it { is_expected.to be true }
    end

    context 'with invalid compass bearing' do
      let(:direction) { ToyRobot::Direction.new name: 'Starward' }

      it { is_expected.to be false }
    end
  end

  describe "#turn_left!" do
    it { is_expected.to respond_to :turn_left! }

    before { compass.bearing = ToyRobot::Direction.north }

    it "one call turns the compass 90 degrees to the left" do
      compass.turn_left!
      expect(compass.bearing).to eq ToyRobot::Direction.west
    end

    it "two calls turns the compass 180 degrees to the left" do
      2.times { compass.turn_left! }
      expect(compass.bearing).to eq ToyRobot::Direction.south
    end

    it "three calls turns the compass 90 degrees to the left" do
      3.times { compass.turn_left! }
      expect(compass.bearing).to eq ToyRobot::Direction.east
    end

    it "four calls turns the compass a full circle" do
      4.times { compass.turn_left! }
      expect(compass.bearing).to eq ToyRobot::Direction.north
    end

  end

  describe "#turn_right!" do

    it { is_expected.to respond_to :turn_right! }

    before { compass.bearing = ToyRobot::Direction.north }

    it "one call turns the compass 90 degrees to the right" do
      compass.turn_right!
      expect(compass.bearing).to eq ToyRobot::Direction.east
    end

    it "two calls turns the compass 180 degrees to the right" do
      2.times { compass.turn_right! }
      expect(compass.bearing).to eq ToyRobot::Direction.south
    end

    it "three calls turns the compass 90 degrees to the right" do
      3.times { compass.turn_right! }
      expect(compass.bearing).to eq ToyRobot::Direction.west
    end

    it "four calls turns the compass a full circle" do
      4.times { compass.turn_right! }
      expect(compass.bearing).to eq ToyRobot::Direction.north
    end

  end
end
