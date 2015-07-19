RSpec.describe ToyRobot::Direction do

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :x_difference }
  it { is_expected.to respond_to :y_difference }
  it { is_expected.to be_frozen }

  describe "::NORTH" do
    subject { described_class::NORTH }

    its(:name) { is_expected.to eq 'NORTH' }
    its(:x_difference) { is_expected.to eq 0 }
    its(:y_difference) { is_expected.to eq 1 }
  end

  describe "::EAST" do
    subject { described_class::EAST }

    its(:name) { is_expected.to eq 'EAST' }
    its(:x_difference) { is_expected.to eq 1 }
    its(:y_difference) { is_expected.to eq 0 }
  end

  describe "::SOUTH" do
    subject { described_class::SOUTH }

    its(:name) { is_expected.to eq 'SOUTH' }
    its(:x_difference) { is_expected.to eq 0 }
    its(:y_difference) { is_expected.to eq -1 }
  end

  describe "::WEST" do
    subject { described_class::WEST }

    its(:name) { is_expected.to eq 'WEST' }
    its(:x_difference) { is_expected.to eq -1 }
    its(:y_difference) { is_expected.to eq 0 }
  end

end
