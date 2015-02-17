class RemoveImagesFromMicroArrayImages < ActiveRecord::Migration
  def up
  	remove_column(:micro_array_images, :images)
  end

  def down
  end
end
