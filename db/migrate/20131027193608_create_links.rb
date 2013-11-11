class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :source, index: true
      t.datetime :parsed_at
      t.boolean :success

      t.timestamps
    end
  end
end
