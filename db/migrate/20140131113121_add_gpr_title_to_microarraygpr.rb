class AddGprTitleToMicroarraygpr < ActiveRecord::Migration
  def change
    add_column :microarraygprs, :gpr_title, :string
  end
end
