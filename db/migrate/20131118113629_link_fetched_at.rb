class LinkFetchedAt < ActiveRecord::Migration
  def up
    rename_column :links, :parsed_at, :fetched_at
  end

  def down
    rename_column :links, :fetched_at, :parsed_at
  end
end
