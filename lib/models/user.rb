class User < ActiveRecord::Base
  has_many :user_wines
  has_many :wines, through: :user_wines

end