class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.primary_key :id
      t.string :service
      t.float :cost
      t.string :payment_method
      t.date :date
      t.belongs_to :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
