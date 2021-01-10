class CreateFormOfPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :form_of_payments do |t|
      t.string :type_payment, null: false

      t.timestamps
    end
  end
end
