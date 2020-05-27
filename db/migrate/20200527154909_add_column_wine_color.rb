class AddColumnWineColor < ActiveRecord::Migration[6.0]
  def change
    add_column :wines, :color, :string
  end
end
