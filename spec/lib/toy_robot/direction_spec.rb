RSpec.describe ToyRobot::Direction do

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :x_difference }
  it { is_expected.to respond_to :y_difference }
  it { is_expected.to be_frozen }

  describe "::north" do
    subject { described_class.north }

    its(:name) { is_expected.to eq 'north' }
    its(:x_difference) { is_expected.to eq 0 }
    its(:y_difference) { is_expected.to eq 1 }
  end

  describe "::east" do
    subject { described_class.east }

    its(:name) { is_expected.to eq 'east' }
    its(:x_difference) { is_expected.to eq 1 }
    its(:y_difference) { is_expected.to eq 0 }
  end

  describe "::south" do
    subject { described_class.south }

    its(:name) { is_expected.to eq 'south' }
    its(:x_difference) { is_expected.to eq 0 }
    its(:y_difference) { is_expected.to eq -1 }
  end

  describe "::west" do
    subject { described_class.west }

    its(:name) { is_expected.to eq 'west' }
    its(:x_difference) { is_expected.to eq -1 }
    its(:y_difference) { is_expected.to eq 0 }
  end

end
