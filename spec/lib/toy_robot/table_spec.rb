require 'spec_helper'

RSpec.describe ToyRobot::Table do
  let(:width)  { 5 }
  let(:height) { 5 }
  subject(:table) { described_class.new(width: width, height: height) }

  it { is_expected.to respond_to :width }
  it { is_expected.to respond_to :height }
  it { is_expected.to be_frozen }

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

  describe '#inside_bounds?' do
    it { is_expected.to respond_to :inside_bounds? }

    let(:result) { subject.inside_bounds?(point) }

    context 'when given point is inside of the bounds of the table' do
      let(:point) { ToyRobot::Point.new x: 2, y: 3 }

      it 'returns `true`' do
        expect(result).to be true
      end
    end

    context 'when given point is outside of the bounds of the table' do
      let(:point) { ToyRobot::Point.new x: 6, y: 7 }

      it 'returns `false`' do
        expect(result).to be false
      end
    end
  end
end
