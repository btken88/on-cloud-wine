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
    $user = User.find_or_create_by(name: user_name)
    # binding.pry
    system('clear')
    self.class.main_menu
  end

  def self.main_menu
    menu_selections = {
      "Browse Wines" => 1,
      "View Personal Collection" => 2,
      "Exit" => 3
    }
    menu_choice = $prompt.select('Choose an option from the menu below:', menu_selections)

    case menu_choice
    when 1 
      Wine.browse_wines
    when 2
      $user.personal_collection
    when 3
      exit
    end
  end

  def self.select_wine
    print "Please enter the id of the wine you'd like to add to your collection: "
    selection = gets.chomp.to_i
    print "How many would you like to add?: "
    quantity = gets.chomp.to_i
    if selection.zero? || quantity.zero?
      puts 'Please enter a valid ID and Quantity.'
      select_wine
    else
      UserWine.create(wine_id: selection, count: quantity, user_id: $user.id)
    end
  end
end

