class RemoveGprTitleFromMicroarraygpr < ActiveRecord::Migration
  def up
    remove_column :microarraygprs, :gpr_title
    remove_column :microarraygprs, :gpr_file_title
    remove_column :microarraygprs, :gpr_file
  end

  def down
    add_column :microarraygprs, :gpr_title, :string
    add_column :microarraygprs, :gpr_file_title, :string
    add_column :microarraygprs, :gpr_file, :string
  end
end
