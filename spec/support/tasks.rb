require 'rake'

RSpec.configure do |config|
  config.before(:context, task: true) do
    HabitatHumanity::Application.load_tasks
  end
end
