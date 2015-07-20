require 'securerandom'

RSpec.describe "running from the command line", type: :aruba do

  before do
    @aruba_io_wait_seconds = 1
    write_file 'input.txt', input_file
    run 'robot'
    pipe_in_file 'input.txt'
    close_input
  end

  subject { last_command }

  context 'piping in a blank file' do

    let(:input_file) { String.new }

    it { is_expected.to be_successfully_executed }

    its(:stdout) { is_expected.to be_empty }
    its(:stderr) { is_expected.to be_empty }

  end

  context 'piping in random bytes' do

    let(:input_file) do
      # Generate 100 lines of garbage
      (1..100).map { SecureRandom.random_bytes + "\n" }
    end

    it { is_expected.to be_successfully_executed }

    its(:stdout) { is_expected.to be_empty }
    its(:stderr) { is_expected.to be_empty }
  end

  context 'a normal simulation' do

    let(:input_file) do
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

    it { is_expected.to be_successfully_executed }
    its(:stdout) { is_expected.to eq expected_output }
    its(:stderr) { is_expected.to be_empty }

  end

end
