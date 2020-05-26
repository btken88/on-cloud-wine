class CreateUserWines < ActiveRecord::Migration[6.0]
  def change
    create_table :user_wines do |t|
      t.integer :user_id
      t.integer :wine_id
      t.integer :count
    end
  end
end
