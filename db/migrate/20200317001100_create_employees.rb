class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :last_name
      t.string :first_name
      t.float :hours
      t.float :salary
      t.string :cellphone

      t.timestamps
    end
  end
end
