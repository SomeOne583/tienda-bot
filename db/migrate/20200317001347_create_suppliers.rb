class CreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.primary_key :id
      t.string :name
      t.string :contact

      t.timestamps
    end
  end
end
