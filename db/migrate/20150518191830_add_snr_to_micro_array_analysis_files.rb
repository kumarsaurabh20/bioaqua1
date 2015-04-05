class AddSnrToMicroArrayAnalysisFiles < ActiveRecord::Migration
  def change
    add_column :micro_array_analysis_files, :snr, :string
  end
end
