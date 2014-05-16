class Sampling < ActiveRecord::Base

#include ActionController::UrlWriter (deprecated)

include Rails.application.routes.url_helpers
include SamplingsHelper

  validates_presence_of :code, :message => "Can't be empty, field is mandatory. "
  validates_uniqueness_of :code, :case_sensitive => false
  validates_length_of :code, :maximum=>15
  
  #, :scope => :sampling_id --> kappao undefined method `samplingS_id'

  #validates_presence_of :volume, :message => "Can't be empty, field is mandatory. "
  #validates_numericality_of :volume, :less_than => 100

  #validates_numericality_of :air_temperature, :allow_nil => true, :less_than => 100
  #validates_numericality_of :water_temperature, :allow_nil => true, :less_than => 100
  #validates_numericality_of :moisture, :allow_nil => true, :less_than => 100
  #validates_numericality_of :pressure, :allow_nil => true, :less_than => 100
  #validates_numericality_of :windSpeed, :allow_nil => true, :less_than => 100
  #validates_numericality_of :waterFlow, :allow_nil => true, :less_than => 100
  #validates_numericality_of :lightIntensity, :allow_nil => true, :less_than => 100
  #validates_numericality_of :rainfallEvents, :allow_nil => true, :less_than => 100
  #validates_numericality_of :depth, :allow_nil => true, :less_than => 100
  #validates_numericality_of :turbidity, :allow_nil => true, :less_than => 100
  #validates_numericality_of :salinity, :less_than => 100
  #validates_numericality_of :tidalRange, :less_than => 100
  #validates_numericality_of :conductivity, :allow_nil => true, :less_than => 100
  #validates_numericality_of :phosphates, :allow_nil => true, :less_than => 100
  #validates_numericality_of :nitrates, :allow_nil => true, :less_than => 100
  #validates_numericality_of :ph, :allow_nil => true, :less_than => 14

  #validates_numericality_of :nitrogen, :allow_nil => true, :less_than => 100
  #validates_numericality_of :bod5, :allow_nil => true, :less_than => 100
  #validates_numericality_of :cod, :allow_nil => true, :less_than => 100
  #validates_numericality_of :h2osat, :allow_nil => true, :less_than => 100

  #name of the model in lowercase
  belongs_to :sampling_site  #, :null => false
  belongs_to :partner  #, :null => false  --> Unknown key(s): null
  #belongs_to :wfilter
  validates_presence_of :sampling_site
  validates_presence_of :partner

  #COLLECTION:
  #     Firm#clients (similar to Clients.find :all, :conditions =&gt; [&quot;firm_id = ?&quot;, id])
  #:dependent => :delete_all vs :destroy (call destroy children event)
  has_many :filter_samples, :dependent => :destroy
  accepts_nested_attributes_for :filter_samples, :reject_if => lambda {|attrs| attrs[:volume].blank? }, :allow_destroy => true

# can also be used on has_one etc.. associations
#|attrs| attrs['num_filters'] == '0' or attrs['volume'].blank?
#  # This will prevent children_attributes with all empty values to be ignored
#  accepts_nested_attributes_for :children,
#    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
#  # This does the same thing using :all_blank
#  accepts_nested_attributes_for :children, :reject_if => :all_blank


  has_many :protocols, :dependent => :delete_all
 

  belongs_to :batch_sampling
  belongs_to :sampling_equipments


  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    #return self.code + ' ' + self.samplingDate.to_s # + partner.verbose_me
    #return self.name + ' ' + self.samplingDate.strftime("%y%m%d")
    #return self.code  + ' ' + self.sampling_site.code  + ' ' + self.volume.to_s + 'L'
    return self.sampling_site.code  + ' ' + self.volume.to_s + ' lt'
  end
  attr_reader :full_name
  def full_name
    return self.code  + ' ' + self.sampling_site.code  + ' ' + self.volume.to_s + 'L'
  end


    def edit
        #include ActionController::UrlWriter 
        #if auth_sample_user(self.id) or signed_in_and_master?
        "<a href='" + edit_sampling_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
        #else
        #    ""
        #end
    end

    def act
        "<a href='" + sampling_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end

    def site_name
        SamplingSite.find(sampling_site_id).verbose_me
    end

    def partner_name
        Partner.find(partner_id).verbose_me
    end

    def sampling_equipment_name
        #sampling_equipments.verbose_me
#KAPPAO uninitialized constant Sampling::SamplingEquipments
#        sampling_equipment.verbose_me
#KAPPAO undefined local variable or method `sampling_equipment' for #<Sampling:0xb6db2f98>
        SamplingEquipment.find(sampling_equipments_id).verbose_me
    end

    #used for NESTED Model
# -----ATTENTION----- this don't call the filter_sample attribute
    def fs_attributes=(fs_attributes)
        fs_attributes.each do |attributes|
#            logger.warn("----------#{Time.now} - logger attributes submit: #{attributes.inspect}")
#            print("----------#{Time.now} - print attributes submit: #{attributes.inspect}")
#            print("----------#{Time.now} - print attribute code: %s", attributes['code'])
            #@person.children_attributes = [ { :name => 'Son' }, { :name => 'Daughter' } ]
            #Do not change the child code attribute here because the parent code is not yet created
            if attributes['num_filters'] != '0' && !attributes['volume'].blank?
                filter_samples.build(attributes)
            end
        end
    end
#"fs_attributes"=>[{"volume"=>"23",
# "num_filters"=>"1"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"},
# {"volume"=>"",
# "num_filters"=>"0"}],

end

