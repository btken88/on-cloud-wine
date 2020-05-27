# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :user_wines
  has_many :wines, through: :user_wines

  def personal_collection
    user_wines = wines.map do |wine|
      [wine.name, wine.vintage, wine.winery, wine.varietal, bottle_count(wine)]
    end.uniq
    table = TTY::Table.new %w[Name Vintage Winery Varietal Count], user_wines
    puts table.render(:ascii)
  end

  def bottle_count wine
    UserWine.where(user_id: self.id, wine_id: wine.id).sum(:count)
  end
end
