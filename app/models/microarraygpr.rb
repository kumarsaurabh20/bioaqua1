class Microarraygpr < ActiveRecord::Base

 #include ActionController::UrlWriter (important for act and edit methods below)
 include Rails.application.routes.url_helpers

 include ExperimentHelper

 attr_accessible :gpr_file, :id, :code, :loaded_at, :barcode, :partner_id, :note, :gpr_file_file_name,
:gpr_file_content_type, :gpr_file_file_size, :gpr_file_updated_at, :gpr_dir, :gpr_title

  #validates_presence_of :gpr_title, :message => "Can't be empty, field is mandatory. "
  #validates_presence_of :gpr_file_title, :message => "Can't be empty, field is mandatory. "
  #validates_presence_of :gpr_file, :message => "Can't be empty, field is mandatory. "



   has_one :experiment
   belongs_to :partner
   has_many :gpr_datas, :dependent => :destroy
   has_one :gpr_header, :dependent => :destroy


  #for paperclip
  has_attached_file :gpr_file


  attr_reader :verbose_me
  def verbose_me
    just_filename = File.basename(path) 
      if just_filename =~ /(^\d+)?\s.+$/
        file_part = $1
      end
      if self.barcode.blank?
            return 'GPR-' + self.id.to_s + '-' +  self.code.to_s  + '-' + file_part.to_s
        else
            return 'GPR-' + self.id.to_s + '-' +  self.code.to_s  + '-' + self.barcode.to_s  + '-' + file_part.to_s
        end   
  end


  attr_reader :path
  def path
    return File.join(self.gpr_dir, self.gpr_title) 
  end


  def gpr_code
      self.verbose_me
  end

  def partner_name
      Partner.find(self.partner_id.to_i).verbose_me
  end

  def title
      self.gpr_title
  end

  def gpr_upload_date
      self.loaded_at.to_s
  end

  def bcode
      self.barcode
  end

  def edit
        #include ActionController::UrlWriter 
        #if auth_sample_user(self.id) or signed_in_and_master?
        "<a href='" + edit_microarraygpr_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
    end

    def act
        "<a href='" + microarraygpr_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end




end
