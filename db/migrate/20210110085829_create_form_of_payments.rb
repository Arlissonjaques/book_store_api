class CreateFormOfPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :form_of_payments do |t|
      t.string :type_payment

      t.timestamps
    end
  end
end
