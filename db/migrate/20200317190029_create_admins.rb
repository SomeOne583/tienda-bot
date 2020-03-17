class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :telegram_id

      t.timestamps
    end
  end
end
