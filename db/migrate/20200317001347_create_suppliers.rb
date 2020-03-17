class CreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.integer :id
      t.string :name
      t.string :contact

      t.timestamps
    end
  end
end
