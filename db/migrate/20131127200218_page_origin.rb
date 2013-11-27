class PageOrigin < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.string :origin
    end
  end
end
