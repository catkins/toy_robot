require 'securerandom'

RSpec.describe "input from STDIN" do

  before { ToyRobot::CLI.input_io = StringIO.new input }

  let(:output) do
    capture(:stdout) { ToyRobot::CLI.start %w(simulate) }
  end

  context 'blank input' do
    let(:input) { '' }

    it "does not output anything" do
      expect(output).to eq ''
    end
  end

  context 'with garbage input' do
    let(:input) do
      (1..100).map { SecureRandom.random_bytes(50) }.join "\n"
    end

    it "does not output anything" do
      expect(output).to eq ''
    end
  end

  context 'a normal simulation' do
    let(:input) do
      <<-EOF.strip_heredoc
        PLACE 0,0,NORTH
        MOVE
        REPORT
        PLACE 0,0,NORTH
        LEFT
        REPORT
        PLACE 1,2,EAST
        MOVE
        MOVE
        LEFT
        MOVE
        REPORT
      EOF
    end

    let(:expected_output) do
      <<-EOF.strip_heredoc
        0,1,NORTH
        0,0,WEST
        3,3,NORTH
      EOF
    end

    it 'has the correct console output' do
      expect(output).to eq expected_output
    end
  end
end
