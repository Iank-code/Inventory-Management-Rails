class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :quantity, :default =>  0
      t.integer :price
      t.boolean :isBelowLimit, :default => false, :null => true

      t.timestamps
    end
  end
end
