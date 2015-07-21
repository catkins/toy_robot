require 'rspec/core/rake_task'

# Default directory to look in is `/spec`
# Run with `rake spec`
RSpec::Core::RakeTask.new(:spec) do |task|
  ENV['COVERAGE'] = 'enabled'
  task.rspec_opts = ['--color', '--order', 'rand']
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task build: [:spec, :rubocop]

task default: :build
