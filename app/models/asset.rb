class Asset < ActiveRecord::Base
  # attr_accessible :title, :body
   belongs_to :batch_oligo

   has_attached_file :fiolse,
                     :url => "/:attachment/:basename.:extension",
                     :path => ":rails_root/public/:attachment/:basename.:extension"
end
