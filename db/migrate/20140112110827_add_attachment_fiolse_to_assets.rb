class AddAttachmentFiolseToAssets < ActiveRecord::Migration
  def self.up
    change_table :assets do |t|
      t.attachment :fiolse
    end
  end

  def self.down
    drop_attached_file :assets, :fiolse
  end
end
