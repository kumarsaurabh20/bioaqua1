class AddAttachmentGalFileToMicroarraygals < ActiveRecord::Migration
  def self.up
    change_table :microarraygals do |t|
      t.attachment :gal_file
    end
  end

  def self.down
    drop_attached_file :microarraygals, :gal_file
  end
end
