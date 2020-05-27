class User < ActiveRecord::Base
  has_many :user_wines
  has_many :wines, through: :user_wines

  def personal_collection
    wines
  
  end

end