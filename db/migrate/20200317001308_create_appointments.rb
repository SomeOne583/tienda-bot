class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.date :initial_date
      t.date :final_date
      t.belongs_to :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
