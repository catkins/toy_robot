require 'spec_helper'

RSpec.describe ToyRobot::Table do
  let(:width)  { 5 }
  let(:height) { 5 }
  subject(:table) { described_class.new(width: width, height: height) }

  it { is_expected.to respond_to :width }
  it { is_expected.to respond_to :height }

  describe '#obstructions' do
    its(:obstructions) { is_expected.to be_a Set }
  end

  describe '#place_object!' do
    before { table.place_object! position }

    context 'placing an object on a valid square' do
      let(:position) { ToyRobot::Point.new x: 2, y: 3 }

      its(:obstructions) { is_expected.to include position }
    end

    context 'placing an object on a invalid square' do
      let(:position) { ToyRobot::Point.new x: 7, y: 2 }

      its(:obstructions) { is_expected.not_to include position }
    end
  end

  describe '#position_is_vacant?' do
    subject(:result) { table.position_is_vacant? position }

    context 'position is not on table' do
      let(:position) { ToyRobot::Point.new x: 7, y: 2 }

      it { is_expected.to eq false }
    end

    context 'position is on table' do
      let(:position) { ToyRobot::Point.new x: 2, y: 3 }

      context 'when an obstruction is at position' do
        before { table.place_object! position }

        it { is_expected.to eq false }
      end

      context 'when an obstruction is not at position' do
        it { is_expected.to eq true }
      end
    end
  end

  describe '#valid?' do
    it { is_expected.to respond_to :valid? }

    context 'when width is greater than zero' do
      context 'but height is not' do
        let(:height) { 0 }

        its(:valid?) { is_expected.to be false }
      end

      context 'and height is greater than zero' do
        let(:height) { 3 }

        its(:valid?) { is_expected.to be true }
      end
    end

    context 'when height is greater than zero' do
      context 'but width is not' do
        let(:width) { 0 }

        its(:valid?) { is_expected.to be false }
      end
    end
  end
end
