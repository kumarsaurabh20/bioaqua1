class AddProbeToMicroArrayAnalysisFiles < ActiveRecord::Migration
  def change
    add_column :micro_array_analysis_files, :probe, :string
  end
end
