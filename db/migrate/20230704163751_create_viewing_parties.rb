# frozen_string_literal: true

class CreateViewingParties < ActiveRecord::Migration[7.0]
  def change
    create_table :viewing_parties do |t|
      t.datetime :date
      t.datetime :time
      t.integer :host_id
      t.integer :duration
      t.integer :movie_id

      t.timestamps
    end
  end
end
