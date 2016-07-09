# Redirects console output to dev/null during testing
RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout

  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.open(File::NULL, 'w')
    $stdout = File.open(File::NULL, 'w')
  end

  config.after(:all) do
    [$stderr, $stdout].each(&:close)
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
