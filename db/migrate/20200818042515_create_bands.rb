# frozen_string_literal: true

class CreateBands < ActiveRecord::Migration[6.0]
  def change
    create_table :bands do |t|
      t.string :name

      t.timestamps
    end
  end
end
