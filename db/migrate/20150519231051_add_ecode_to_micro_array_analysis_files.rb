class AddEcodeToMicroArrayAnalysisFiles < ActiveRecord::Migration
  def change
    add_column :micro_array_analysis_files, :ecode, :string
  end
end
