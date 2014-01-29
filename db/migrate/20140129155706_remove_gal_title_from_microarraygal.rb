class RemoveGalTitleFromMicroarraygal < ActiveRecord::Migration
  def up
    remove_column :microarraygals, :gal_title
    remove_column :microarraygals, :gal_file_title
    remove_column :microarraygals, :gal_file
  end

  def down
    add_column :microarraygals, :GalTitle, :string
    add_column :microarraygals, :gal_file_title
    add_column :microarraygals, :gal_file
  end
end
