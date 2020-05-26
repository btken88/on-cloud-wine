class CreateWines < ActiveRecord::Migration[6.0]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :varietal
      t.integer :vintage
      t.string :winery
    end
  end
end
