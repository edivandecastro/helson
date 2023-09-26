class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications, id: :uuid do |t|
      t.string :name,          null: false
      t.string :client_id,     null: false
      t.string :client_secret, null: false
      t.text :redirect_uri,    null: false
      t.string :scopes,        null: false
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :applications, :client_id, unique: true
  end
end
