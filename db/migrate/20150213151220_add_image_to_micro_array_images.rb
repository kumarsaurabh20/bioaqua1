class AddImageToMicroArrayImages < ActiveRecord::Migration
  def change
    add_column :micro_array_images, :image, :string
  end
end
