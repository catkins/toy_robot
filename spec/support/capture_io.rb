# rubocop:disable Lint/Eval
module CaptureIO
  # https://github.com/erikhuda/thor/blob/81dadf41b1d0422d1be1a7b2655603b47e8ff46a/spec/helper.rb#L48
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
end
# rubocop:enable Lint/Eval

RSpec.configure do |config|
  config.include CaptureIO
end
