class CreateAccessGrants < ActiveRecord::Migration[7.0]
  def change
    create_table :access_grants, id: :uuid do |t|
      t.string :token, null: false
      t.integer :expires_in, null: false
      t.string :redirect_uri, null: false
      t.datetime :revoked_at
      t.string :scopes, null: false
      t.references :application, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :access_grants, :token, unique: true
  end
end
