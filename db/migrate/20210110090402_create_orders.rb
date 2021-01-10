class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :client, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.references :form_of_payment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
