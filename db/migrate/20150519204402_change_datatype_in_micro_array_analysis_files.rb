class ChangeDatatypeInMicroArrayAnalysisFiles < ActiveRecord::Migration
  def up
	change_column :micro_array_analysis_files, :probe, :longtext
	change_column :micro_array_analysis_files, :tsi, :longtext
	change_column :micro_array_analysis_files, :snr, :longtext
  end

  def down
	remove_column :micro_array_analysis_files, :probe, :longtext
	remove_column :micro_array_analysis_files, :tsi, :longtext
	remove_column :micro_array_analysis_files, :snr, :longtext
  end
end
