class RemoveImageFromMicroArrayImage < ActiveRecord::Migration
  def up
  	remove_column :micro_array_images, :image
  end

  def down
  	add_column :micro_array_images, :image
  end
end
