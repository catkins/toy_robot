RSpec.describe ToyRobot::Point do

  it { is_expected.to respond_to :x }
  it { is_expected.to respond_to :y }
  it { is_expected.to be_frozen }

  describe '#step_in_direction' do
    let(:starting_point) { described_class.new x: 1, y: 2 }
    let(:direction) { ToyRobot::Direction.new name: 'onward', x_difference: 1, y_difference: -1 }
    subject(:result) { starting_point.step_in_direction(direction) }

    it "returns a new point" do
      expect(result).not_to eq starting_point
    end

    it "adds the direction's X and Y differences to the new point" do
      expect(result).to eq described_class.new(x: 2, y: 1)
    end
  end

end
