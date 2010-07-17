class AddPageMeta < ActiveRecord::Migration
  def self.up
    create_table :page_meta do |t|
      t.integer :page_id
      t.string :name
      t.string :content
    end
    add_index :page_meta, :page_id
  end

  def self.down
    remove_index :page_meta, :page_id
    drop_table :page_meta
  end
end
