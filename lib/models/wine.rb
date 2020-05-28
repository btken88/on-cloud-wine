# frozen_string_literal: true

class Wine < ActiveRecord::Base
  has_many :user_wines
  has_many :users, through: :user_wines
  def self.browse_wines
    red_or_white = {
      "Red".colorize(:red) => 1,
      "White".colorize(:white) => 2
    }
    color_choice = $prompt.select('What color of wine would you like to peruse?:', red_or_white)
    case color_choice
    when 1
      reds
    when 2
      whites
    end
  end

  def self.reds
    type_of_red = {
      'All Varietals' => 1,
      'Cabernet Franc' => 2,
      'Syrah' => 3,
      'Petit Verdot' => 4,
      'Teroldego' => 5,
      'Merlot' => 6,
      'Graciano' => 7,
      'Blend' => 8,
      'Previous Page' => 9
    }
    choice_of_red = $prompt.select('Your choice of varietal?:', type_of_red)
    case choice_of_red
      # need to create method for creating table of all reds right here
    when 1
      all_wines_by_color 'Red'
    when 2
      add_to_collection 'Cabernet Franc', 'Red'
    when 3
      add_to_collection 'Syrah', 'Red'
    when 4
      add_to_collection 'Petit Verdot', 'Red'
    when 5
      add_to_collection 'Teroldego', 'Red'
    when 6
      add_to_collection 'Merlot', 'Red'
    when 7
      add_to_collection 'Graciano', 'Red'
    when 8
      add_to_collection 'Blend', 'Red'
    when 9
      browse_wines
    end
  end

  def self.whites
    type_of_white = {
      'All Varietals' => 1,
      'Gewürztraminer' => 2,
      'Cabernet Sauvignon' => 3,
      'Riesling' => 4,
      'Voigner' => 5,
      'Moscato' => 6,
      'Chardonnay' => 7,
      'Blend' => 8,
      'Previous Page' => 9
    }
    choice_of_white = $prompt.select('Your choice of varietal?:', type_of_white)
    case choice_of_white
      # Need to create table for all_whites
    when 1
      all_wines_by_color 'White'
    when 2
      add_to_collection 'Gewürztraminer', 'White'
    when 3
      add_to_collection 'Cabernet Sauvignon', 'White'
    when 4
      add_to_collection 'Riesling', 'White'
    when 5
      add_to_collection 'Voigner', 'White'
    when 6
      add_to_collection 'Moscato', 'White'
    when 7
      add_to_collection 'Chardonnay', 'White'
    when 8
      add_to_collection 'Blend', 'White'
    when 9
      browse_wines
    end
  end

  def self.table(varietal, color)
    selected_wines = Wine.all.where(varietal: varietal, color: color)
    binding.pry
    mapped_wines = selected_wines.map do |wine|
      [wine.id, wine.name, wine.vintage, wine.winery, wine.varietal]
    end
    table = TTY::Table.new %w[ID Name Vintage Winery Varietal], mapped_wines
    puts table.render(:ascii)
  end
  
  def self.add_to_collection varietal, color = "Red"||"White"
    table varietal, color
    add_wine?
  end

  def self.add_wine?
    choices = {
      "Add to Personal Collection" => 1,
      "Continue Browsing" => 2
    }
    choice = $prompt.select("Would you care to add to your collection?:", choices)
    case choice
    when 1
      CommandLineInterface.select_wine
      continue_browsing?
    when 2
      self.browse_wines
    end
  end

  def self.continue_browsing?
    continue = {
      "Continue Browsing" => 1,
      "View Personal Collection" => 2
    }
    decision = $prompt.select('Would you like to continue browsing or to see your private collection?', continue)
    case decision
    when 1
      self.select_wine
    when 2
      $user.personal_collection
    end
  end
  def all_wines_by_color color
    wines = Wine.all.where(color: color)
    mapped_reds = red_wines.map do |wine|
      [wine.id, wine.name, wine.vintage, wine.winery, wine.varietal]
    end
    table = TTY::Table.new %w[ID Name Vintage Winery Varietal], mapped_wines
    puts table.render(:ascii)
    CommandLineInterface.select_wine
  end
end
