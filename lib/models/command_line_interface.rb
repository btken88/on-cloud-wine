class CommandLineInterface
  $prompt = TTY::Prompt.new

  def greet
    puts "Welcome to On Cloud Wine! Please enter your name."
    user_name = $prompt.ask('Name:', default: ENV["User"])
    user = User.find_or_create_by(name: user_name)
  end
end