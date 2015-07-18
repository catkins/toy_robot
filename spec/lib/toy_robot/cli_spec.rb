require 'spec_helper'

RSpec.describe ToyRobot::CLI do

  it { is_expected.not_to be_nil }
  it { is_expected.to respond_to :simulate }
end

