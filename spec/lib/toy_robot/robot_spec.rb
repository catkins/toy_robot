require 'spec_helper'

RSpec.describe ToyRobot::Robot do

  let(:table) { ToyRobot::Table.new width: 5, height: 5 }

  subject(:robot) { described_class.new(table: table) }

  it { is_expected.not_to be_nil }

  describe '#facing' do
    it { is_expected.to respond_to :facing }

    context 'before robot has been placed' do
      its(:facing) { is_expected.to eq :nowhere }
    end
  end

  describe '#execute' do
    it { is_expected.to respond_to :execute }

  end

end

