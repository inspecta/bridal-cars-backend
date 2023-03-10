class AddColumnsToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :price, :integer
    add_column :cars, :description, :text
  end
end
