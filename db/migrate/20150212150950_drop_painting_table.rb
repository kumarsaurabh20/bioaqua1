class DropPaintingTable < ActiveRecord::Migration
  def up
  	 drop_table :paintings
  end

  def down
  	add_table :paintings
  end
end
