class AddGalTitleToMicroarraygal < ActiveRecord::Migration
  def change
    add_column :microarraygals, :gal_title, :string
  end
end
