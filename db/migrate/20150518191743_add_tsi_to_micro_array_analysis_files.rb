class AddTsiToMicroArrayAnalysisFiles < ActiveRecord::Migration
  def change
    add_column :micro_array_analysis_files, :tsi, :string
  end
end
