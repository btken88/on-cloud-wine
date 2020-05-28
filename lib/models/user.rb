# frozen_string_literal: true
require 'pry'
class User < ActiveRecord::Base
  has_many :user_wines
  has_many :wines, through: :user_wines

  def personal_collection
<<<<<<< HEAD
    if !has_wines?
=======
    if $user.wines.empty?
>>>>>>> 52637a0272f1c71379b0e505ce6a79d1438d3d44
      empty_navigator
    else
      user_wines = wines.map do |wine|
        [wine.name, wine.vintage, wine.winery, wine.varietal, bottle_count(wine), wine.id]
      end.uniq
      table = TTY::Table.new %w[Name Vintage Winery Varietal Count ID], user_wines
      puts table.render(:ascii)
      puts ""
      collection_navigator
    end
  end

  def collection_navigator
    menu_options = {
      "Pull" => 1, 
      "Add to Collection" => 2,
      "Main Menu" => 3
    }
    menu_selection = $prompt.select("Are you pulling from your private collection today?:", menu_options)
    case menu_selection
    when 1
      self.drink
    when 2
      Wine.browse_wines
    when 3
      CommandLineInterface.main_menu
    end
  end

  def empty_navigator
    empty_options ={
      "Add to Collection" => 1,
      "Main Menu" => 2
    }
    empty_option = $prompt.select("Unfortunately your personal collection is currently empty please peruse from our selection:", empty_options)
    case empty_option
    when 1
      Wine.browse_wines
    when 2
      CommandLineInterface.main_menu
    end
  end

  def bottle_count wine
    UserWine.where(user_id: self.id, wine_id: wine.id).sum(:count)
  end

  def drink
    if has_wines?
      wine_id = $prompt.ask(
        'Please enter the ID of the wine you would like to uncork or "q" to cancel: '.light_green)
      if wine_id == 'q'
        personal_collection
      else
        wine_record = UserWine.where(user_id: self.id, wine_id: wine_id).first
        if wine_record
          wine_record[:count] -= 1
          if wine_record[:count].zero?
            UserWine.delete(wine_record[:id])
          else
            wine_record.save
          end
          binding.pry
          system('clear')
          Ascii.bottle_and_glasses
          puts "Enjoy your bottle of #{wine_record.wine.name}!".light_green
          puts
          choices = {'View personal collection' => 1, 'Main menu' => 2}
          selection = $prompt.select(
            'Would you like to return to your personal collection or the main menu?', choices)
          case selection
          when 1
            personal_collection
          when 2
            CommandLineInterface.main_menu
          end
        else
          puts 'Please select a wine you have in your collection'.light_red
          drink
        end
      end
    end
  end

  def has_wines?
    if wines.first
      true
    else
      empty_navigator
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
