class CreateAccessTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :access_tokens, id: :uuid do |t|
      t.string :token, null: false
      t.string :refresh_token, null: false
      t.integer :expires_in, null: false
      t.datetime :revoked_at
      t.string :scopes, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :application, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
