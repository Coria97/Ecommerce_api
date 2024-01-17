class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.integer :status

      t.timestamps
    end
  end
end
