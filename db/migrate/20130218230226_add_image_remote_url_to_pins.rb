class AddImageRemoteUrlToPins < ActiveRecord::Migration
  def self.up
    add_column :pins, :image_remote_url, :string
  end

  def self.down
    remove_column :pins, :image_remote_url
  end
end