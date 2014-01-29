class AddAttachmentSafiToSamplingAssets < ActiveRecord::Migration
  def self.up
    change_table :sampling_assets do |t|
      t.attachment :safi
    end
  end

  def self.down
    drop_attached_file :sampling_assets, :safi
  end
end
