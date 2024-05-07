require_relative 'quiz'

Quiz::Config.configure do |config|
  config.yaml_dir = File.join(__dir__, 'yml')
  config.answers_dir = File.join(__dir__, 'answers')
  config.in_ext = "yml"
end
