class AddGalDirToMicroarraygal < ActiveRecord::Migration
  def change
    add_column :microarraygals, :gal_dir, :string
  end
end
