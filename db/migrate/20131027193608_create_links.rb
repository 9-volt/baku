class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url,          unique: true, null: false
      t.string :news_source,  index: true
      t.datetime :parsed_at
      t.boolean :attempted,   default: false
      t.boolean :success,     default: false

      t.timestamps
    end
  end
end
