class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.integer :id, :primary_key => true
      t.string :first_name
      t.string :contact

      t.timestamps
    end
  end
end
