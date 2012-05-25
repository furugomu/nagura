# -*- encoding: UTF-8 -*-
class CreateDojos < ActiveRecord::Migration
  def change
    create_table :dojos do |t|
      t.references :rank
      t.string :personality, limit: 7 # passion 7もじ
      t.integer :level
      t.string :leader
      t.integer :mbgaid
      t.string :force
      t.integer :force_value
      t.text :description

      t.timestamps
    end
    add_index :dojos, :rank_id
  end
end
