class AddColumnToCountry < ActiveRecord::Migration
  def self.up
  add_column :countries, :name, :string
  add_column :countries, :code, :string 
  end

  def self.down
  remove_column :countries, :name
  remove_column :countries, :code
  end

end



