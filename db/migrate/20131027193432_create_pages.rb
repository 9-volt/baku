class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :link
      t.text :content

      t.timestamps
    end
  end
end
