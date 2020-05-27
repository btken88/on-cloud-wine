class Wine < ActiveRecord::Base
  has_many :user_wines
  has_many :users, through: :user_wines
  def self.browse_wines
    red_or_white = {
      "Red" => 1,
      "White" => 2
    }
    color_choice =  $prompt.select('What color of wine would you like to peruse?:', red_or_white)
    case color_choice
    when 1
      self.reds
    when 2
      self.whites
    end
  end
  def self.reds
    type_of_red = {
      "All Varietals" => 1,
      "Cabernet Franc" => 2,
      "Syrah" => 3,
      "Petit Verdot" => 4,
      "Teroldego" => 5,
      "Merlot" => 6,
      "Graciano" => 7,
      "Blend" => 8,
      "Previous Page" => 9
    }
    choice_of_red = $prompt.select("Your choice of varietal?:", type_of_red)
    case choice_of_red
      # need to create method for creating table of all reds right here
    when 1
    when 2
      add_to_collection "Cabernet Franc"
    when 3
      add_to_collection "Syrah"
    when 4 
      add_to_collection "Petit Verdot"
    when 5
      add_to_collection "Teroldego"
    when 6
      add_to_collection "Merlot"
    when 7
      add_to_collection "Graciano"
    when 8
      add_to_collection "Blend", "Red"
    when 9
      browse_wines
    end
  end
  def self.whites
    type_of_white = {
    "All Varietals" => 1,
    "Gewürztraminer" => 2,
    "Cabernet Sauvignon" => 3,
    "Riesling" => 4,
    "Voigner" => 5,
    "Moscato" => 6,
    "Chardonnay" => 7,
    "Blend" =>8,
    "Previous Page" => 9
    }
    choice_of_white = $prompt.select("Your choice of varietal?:", type_of_white)
    case choice_of_white
      #Need to create table for all_whites
    when 1
      self.all_whites
    when 2
      add_to_collection "Gewürztraminer"
    when 3
      add_to_collection "Cabernet Sauvignon"
    when 4
      add_to_collection "Riesling"
    when 5
      add_to_collection "Voigner"
    when 6
      add_to_collection "Moscato"
    when 7
      add_to_collection "Chardonnay"
    when 8
      add_to_collection "Blend", "White"
    when 9
      browse_wines
    end
  end
  def self.table varietal, color
    selected_wines = Wine.all.where(varietal: varietal, color: color)
    mapped_wines = selected_wines.map do |wine|
      [wine.id, wine.name, wine.vintage, wine.winery, wine.varietal]
    end
    table = TTY::Table.new ['ID', 'Name', 'Vintage', 'Winery', 'Varietal'], mapped_wines
    puts table.render(:ascii)
  end
  def self.add_to_collection varietal, color = "Red"||"White"
    table varietal, color
    CommandLineInterface.select_wine
    end
end