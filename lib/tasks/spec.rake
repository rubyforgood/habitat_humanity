namespace :spec do
  task :rubocop do
    raise unless system 'bundle exec rubocop'
  end

  desc 'Run RSpec tests and rubocop'
  task all: %i[spec rubocop]
end
