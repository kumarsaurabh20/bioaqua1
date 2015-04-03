class AddDolToNucleicAcids < ActiveRecord::Migration
  def change
    add_column :nucleic_acids, :dol, :string
  end
end
