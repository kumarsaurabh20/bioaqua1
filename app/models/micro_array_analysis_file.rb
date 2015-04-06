class MicroArrayAnalysisFile < ActiveRecord::Base

  serialize :probe, Array	
  serialize :tsi, Array
  serialize :snr, Array 	

  belongs_to :experiment

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.MIANE_Standard
  end
end

