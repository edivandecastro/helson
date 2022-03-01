class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications, id: :uuid do |t|
      t.string :name,          null: false
      t.string :client_id,     null: false
      t.string :client_secret, null: false
      t.text :redirect_uri,    null: false
      t.string :scopes,        null: false
      t.integer :owner_id,     null: false
      t.string :owner_type,    null: false

      t.timestamps
    end

    add_index :applications, :client_id, unique: true
    add_index :applications, [:owner_id, :owner_type]
  end
end
