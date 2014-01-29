class AddAttachmentPhotoToImageAssets < ActiveRecord::Migration
  def self.up
    change_table :image_assets do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :image_assets, :photo
  end
end
