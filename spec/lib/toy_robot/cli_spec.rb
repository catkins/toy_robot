require 'active_support/core_ext/string/strip'
require 'spec_helper'

RSpec.describe ToyRobot::CLI do

  let(:input) { "" }

  # CLI consumes $stdin by default, but we can't block on reads from stdin during testing
  let(:input_io) { StringIO.new input }

  let(:flags) { { width: 5, height: 5 } }

  subject(:cli) do
    described_class.new.tap do |app|
      app.options  = flags
      app.input_io = input_io
    end
  end

  it { is_expected.to respond_to :robot }
  it { is_expected.to respond_to :input_io }

  describe "Thor options" do

    it 'registers command named simulate' do
      expect(described_class.commands.keys).to include 'simulate'
    end

    it 'registers #simulate as default task' do
      expect(described_class.default_task).to eq 'simulate'
    end

  end

  describe '#simulate' do
    it { is_expected.to respond_to :simulate }

    describe 'command delegation' do

      let(:input) {
        <<-EOF.strip_heredoc
          SOME_COMMAND
          ANOTHER_COMMAND 1,2,3

          SOMETHING_ELSE 5,4,2
        EOF
      }

      let(:executor) { instance_double("ToyRobot::Executor") }
      before { allow(cli).to receive(:executor) { executor } }

      it 'parses input and delegates to Executor#call' do
        expect(executor).to receive(:call).with(:some_command, []).ordered
        expect(executor).to receive(:call).with(:another_command, ["1","2","3"]).ordered
        expect(executor).to receive(:call).with(:something_else, ["5","4","2"]).ordered

        subject.simulate
      end

      it 'ignores blank lines' do
        expect(executor).to receive(:call).exactly(3).times

        subject.simulate
      end
    end
  end

end

