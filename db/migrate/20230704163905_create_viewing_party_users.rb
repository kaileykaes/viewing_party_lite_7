# frozen_string_literal: true

class CreateViewingPartyUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :viewing_party_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :viewing_party, null: false, foreign_key: true

      t.timestamps
    end
  end
end
