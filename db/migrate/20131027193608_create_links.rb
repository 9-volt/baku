class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url,    unique: true, null: false
      t.string :source, index: true
      t.datetime :parsed_at
      t.boolean :attempted
      t.boolean :success

      t.timestamps
    end
  end
end
