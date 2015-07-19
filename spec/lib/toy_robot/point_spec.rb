RSpec.describe ToyRobot::Point do

  it { is_expected.to respond_to :x }
  it { is_expected.to respond_to :y }
  it { is_expected.to be_frozen }

end
