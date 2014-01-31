class AddAttachmentGprFileToMicroarraygprs < ActiveRecord::Migration
  def self.up
    change_table :microarraygprs do |t|
      t.attachment :gpr_file
    end
  end

  def self.down
    drop_attached_file :microarraygprs, :gpr_file
  end
end
