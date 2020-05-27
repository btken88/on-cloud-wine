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

  def drink wine_id
    wine_record = UserWine.where(user_id: self.id, wine_id: wine_id).first
    if wine_record
      wine_record[:count] -= 1
      if wine_record[:count] == 0
        UserWine.delete(wine_record[:id])
      else
        wine_record.save
      end
    else
      puts "Please select a wine you have in your collection"
    end
  end
end
