class MicroArrayAnalysisFile < ActiveRecord::Base

  serialize :probe, Array	
  serialize :tsi, Array
  serialize :snr, Array 	

 before_save :make_array_probe
 before_save :make_array_tsi
 before_save :make_array_snr	
 
 belongs_to :experiment



 def make_array_probe
	#self.probe=self.probe.split(" ")
	self.probe.reject!(&:blank?) if self.probe
 end

 def make_array_tsi
	#self.tsi=self.tsi.split(" ")
	self.tsi.reject!(&:blank?) if self.tsi
 end
 
 def make_array_snr
	#self.snr=self.snr.split(" ")
	self.snr.reject!(&:blank?) if self.snr
 end

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.MIANE_Standard
  end
end

