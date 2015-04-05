class AddGprcodeToMicroArrayAnalysisFiles < ActiveRecord::Migration
  def change
    add_column :micro_array_analysis_files, :gprcode, :string
  end
end
