class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
