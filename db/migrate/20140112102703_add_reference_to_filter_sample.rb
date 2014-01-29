class AddReferenceToFilterSample < ActiveRecord::Migration
  def self.up

    change_table :filter_samples do |t|
        t.references :filter_sample_preparations, :null => true
    end


  end

  def self.down
    #remove_column :filter_samples, :filter_sample_preparations_id
    remove_references :filter_samples, :filter_sample_preparations

  end
end
