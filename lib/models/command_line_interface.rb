class CommandLineInterface 
  $prompt = TTY::Prompt.new
  
  attr_accessor :user


  def greet
    Ascii.greeting_art

    puts "                        Welcome to On Cloud Wine! Please enter your name."
  end

  def run
    greet
    puts ""
    user_name = $prompt.ask('                                    Name:', default: ENV["User"],)
    @user = User.find_by(name: user_name)
    system('clear')
    
  end

  def main_menu
    menu_selections = {
      "Browse Wines" => 1,
      "View Personal Collection" => 2,
      "Help" => 3,
      "Exit" => 4
    }
    menu_choice = $prompt.select('Choose an option from the menu below:', menu_selections)

    case menu_choice
    when 1 
      Wine.browse_wines
    when 2
      User.personal_collection
    when 3
      self.help
    when 4
      exit
    end
  end

end

