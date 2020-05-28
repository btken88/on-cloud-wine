# frozen_string_literal: true
require 'pry'
class User < ActiveRecord::Base
  has_many :user_wines
  has_many :wines, through: :user_wines

  def personal_collection
    user_wines = wines.map do |wine|
      [wine.name, wine.vintage, wine.winery, wine.varietal, bottle_count(wine), wine.id]
    end.uniq
    table = TTY::Table.new %w[Name Vintage Winery Varietal Count ID], user_wines
    puts table.render(:ascii)
  end

  def bottle_count wine
    UserWine.where(user_id: self.id, wine_id: wine.id).sum(:count)
  end

  def drink
    if has_wines?
      wine_id = $prompt.ask('Please enter the ID of the wine you would like to uncork: '.light_green)
      wine_record = UserWine.where(user_id: self.id, wine_id: wine_id).first
      if wine_record
        wine_record[:count] -= 1
        if wine_record[:count] == 0
          UserWine.delete(wine_record[:id])
        else
          wine_record.save
        end
        system('clear')
        Ascii.bottle_and_glasses
        puts "Enjoy your bottle of #{wine_record.wine.name}!".light_green
        puts
        choices = {"View personal collection" => 1, "Main menu" => 2}
        selection = $prompt.select("Would you like to return to your personal collection or the main menu?", choices)
        case selection
        when 1
          personal_collection
        when 2
          CommandLineInterface.main_menu
        end
      else
        puts "Please select a wine you have in your collection".light_red
        drink
      end
    else
      puts "Your collection is currently empty. Please add wine to your collection before trying to drink.".red
      puts
      choices = {"Return to main menu" => 1, "Browse wines" => 2}
      selection = $prompt.select("Would you like to return to the main menu or browse wines?", choices)
      if selection == 1
        CommandLineInterface.main_menu
      else
        Wine.browse_wines
      end
    end
  end

  def has_wines?
    if wines.first
      true
    else
      false
    end
  end
end
