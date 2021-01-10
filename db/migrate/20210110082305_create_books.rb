class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
