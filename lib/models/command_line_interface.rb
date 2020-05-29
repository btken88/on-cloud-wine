require 'tty-prompt'

class CommandLineInterface 
  $prompt = TTY::Prompt.new(symbols: {marker: '🍷'})
  
  attr_accessor :user


  def greet
    Ascii.alt_greeting

    puts "Welcome to On Cloud Wine! With On Cloud Wine you can browse some of Colorado's most popular wines and add them to
your own personal wine collection. Please enter your name to begin."
  end

  def run
    system('clear')
    greet
    puts ""
    user_name = $prompt.ask('                                            Name:', default: ENV["User"],)
    $user = User.find_or_create_by(name: user_name)
    # binding.pry
    system('clear')
    self.class.main_menu
  end

  def self.main_menu
    system('clear')
    menu_selections = {
      "Browse Wines" => 1,
      "View Personal Collection" => 2,
      "Add a Colorado Wine" => 3,
      "Exit" => 4
    }
    menu_choice = $prompt.select("Welcome #{$user.name}. Choose an option from the menu below:", menu_selections)

    case menu_choice
    when 1 
      Wine.browse_wines
    when 2
      $user.personal_collection
    when 3
      Wine.add_wine_to_database
    when 4
      system('clear')
      puts "🥂 Thanks for using On Cloud Wine today #{$user.name} - we look forward to your next visit! 🥂"
      sleep(4)
      system('clear')
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

