class AddGprDirToMicroarraygpr < ActiveRecord::Migration
  def change
    add_column :microarraygprs, :gpr_dir, :string
  end
end
