class OligoSequencesController < AuthController 

  require 'csv'
  require 'bio'
  #require 'spreadsheet'
  #require 'to_xls'

 #The error TypeError: $.ajaxPrefilter is not a function in firebug will go by using following line but 
 #Downloading selected oligos functionalities would not work after using the below lines.
 #<%= javascript_include_tag "http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" %>
 #<%= javascript_include_tag "http://code.jquery.com/ui/1.8.19/jquery-ui.min.js" %>

  respond_to :xls, :json, :html
  
  protect_from_forgery :except => [:post_data]
  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update, :delete, :destroy]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :oligo_sequences,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end


  # remote_function AJAX CALL 
  #Ko http://apidock.com/rails/v2.3.8/ActionView/Helpers/PrototypeHelper/remote_function prototype function
  #add to route map.connect 'lookup', :controller => 'oligo_sequences', :action => 'lookup'

  def esearch()
    logger.debug('esearch here')
   
    xsearch = params[:es]
    logger.debug xsearch.to_s
    if !xsearch.nil?
        if !xsearch.include?('[Subtree]')
            xsearch = xsearch + '[Subtree]'
        end
        begin
            @esearch2 = Bio::NCBI::REST::ESearch.taxonomy(xsearch, 'xml')
            
            respond_to do |format|
                format.xml  { render :xml => @esearch2 } 
            end
        rescue Exception => e
            @esearch2 = Bio::NCBI::REST::ESearch.taxonomy(xsearch)
            respond_to do |format|
                format.json  { render :json => @esearch2 }      
            end
        end 
    end       
  end

  def lookup()
    logger.debug('lookup here')
    
    xsearch = params[:st]
    
    if !xsearch.nil?
#onclick="<%= remote_function(
#                           :update => "resbio" ,
#                           :url => { :action => :lookup } , 
#                           :with => "'st='+$('search_tax').value"
#                        ); 
#        %>"

        #@filo =  Bio::PhyloXML::Parser.
        #iSearch = Integer(xsearch)
        #@tree =  Bio::NCBI::REST::EFetch.taxonomy(xsearch)
        @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(xsearch, 'xml')
        
        #ParsedAndSerialized_HTML = xmlparser.new(@tree2)
        respond_to do |format|
            #format.json  { render :json => ParsedAndSerialized_HTML }      
            format.xml  { render :xml => @tree2 }      

            #In libxml2-ruby, I think LibXML::XML::Reader is the best choice,
            #because it is memory efficient than DOM and its API is simpler
            #than that of SAX. LibXML::XML::SAXParser is not bad, but I wonder
            #if the SAX's callback based API makes our codes too complex and
            #difficult to maintain.

#        render :update do |page|
          #page.replace_html 'resbio', 'Done2! --> ' + xsearch 
#          page.replace_html 'resbio', @tree 
#          page.replace_html 'resbio2', @tree2 
        end
    else
        ysearch = params[:id]
        if !xsearch.nil?
            respond_to do |format|
                #format.json  { render :json => @tree }      
                format.xml  { render :xml => @tree }      
            end
        end
    end
  end

#Cascading Drop Down Also called Related Drop Down fields or Dependant Drop Down lists or Dynamic Drop Downs or Dependent Drop Downs.
#    def for_sectionid
#        #you need to sanitize the variables being passed as a parameter
#        @subsections = SubSection.find( :all, :conditions => [" section_id = ?", params[:id]]  ).sort_by{ |k| k['name'] }    
#        @subsection = SubSection.find_all_by_section_id( params[:id]).sort_by{ |k| k['name'] }


#        respond_to do |format|
#            format.json  { render :json => @subsections }      
#        end
#    end


   def post_data
    message=""
    oligo_sequence_params = { :id => params[:id],:dna_sequence => params[:dna_sequence],:name => params[:name],:code => params[:code],:description => params[:description],:partner_id => params[:partner_id],:people_id => params[:people_id],:partner_people_id => params[:partner_people_id],:taxonomy_id => params[:taxonomy_id],:taxonomy_name => params[:taxonomy_name],:oligoDate => params[:oligoDate],:available => params[:available] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        oligo_sequence = OligoSequence.create(oligo_sequence_params)
        message << ('add ok') if oligo_sequence.errors.empty?
      end
      
    when 'edit'
      oligo_sequence = OligoSequence.find(params[:id])
      message << ('update ok') if oligo_sequence.update_attributes(oligo_sequence_params)
    when 'del'
      OligoSequence.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      oligo_sequences = OligoSequence.all
      oligo_sequences.each do |oligo_sequence|
        oligo_sequence.position = params['ids'].index(oligo_sequence.id.to_s) + 1 if params['ids'].index(oligo_sequence.id.to_s) 
        oligo_sequence.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (oligo_sequence && oligo_sequence.errors).blank?  
      oligo_sequence.errors.entries.each do |error|
        message << "<strong>#{OligoSequence.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end


  # GET /oligo_sequences
  # GET /oligo_sequences.xml
  def index
    #@oligo_sequences = OligoSequence.all
    @title = "List of oligo sequences"

    #oligo_sequences = OligoSequence.find(:all, :joins => [:people, :partner]) do
    #KAPPAO: Association named 'people' was not found; perhaps you misspelled it?
    #oligo_sequences = OligoSequence.find(:all, :joins => [:person, :partner]) do
    #Mysql::Error: Unknown column 'oligo_sequences.person_id' in 'on clause': SELECT `oligo_sequences`.* FROM `oligo_sequences`   INNER JOIN `people` ON `people`.id = `oligo_sequences`.person_id  INNER JOIN `partners` ON `partners`.id = `oligo_sequences`.partner_id   LIMIT 0, 20
    #KAPPAO: migrate person generate people table but the rails do not re-construct right renaming
#    _str = ""
   

   #oligo_sequences = OligoSequence.find(:all, :joins => [:partner]) do
   #     if params[:_search] == "true"
   #         name =~ "%#{params[:verbose_me]}%" if params[:verbose_me].present?
   #         dna_sequence =~ "%#{params[:dna_ellipsis]}%" if params[:dna_ellipsis].present?
   #         code =~ "%#{params[:code]}%" if params[:code].present?
   #         taxonomy_name =~ "%#{params[:taxonomy_name]}%" if params[:taxonomy_name].present?
   #         taxonomy_id =~ "%#{params[:taxonomy_id]}%" if params[:taxonomy_id].present?
   #         if params[:available].present?
   #             _str = params[:available].strip.downcase                
   #            if _str == "true" or _str == "1"
   #                 available = "true"
   #             else
   #                available = "false"
   #            end
   #         end    
   #         partner.code =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
   #        people.firstname =~ "%#{params[:people_name]}%" if params[:people_name].present?
   #     end
   #     paginate :page => params[:page], :per_page => params[:rows]      
   #     if params[:sidx] == "verbose_me"
   #         order_by "oligo_sequences.name #{params[:sord]}"
   #     elsif params[:sidx] == "dna_ellipsis"
   #         order_by "dna_sequence #{params[:sord]}"
   #     #After set join conditions we fall in Mysql::Error: Column 'volume' in order clause is ambiguous
   #    #set the database table name and column
   #     elsif params[:sidx] == "code"
   #         order_by "oligo_sequences.code #{params[:sord]}"
   #     elsif params[:sidx] == "partner_name"
   #         order_by "partners.code #{params[:sord]}"
   #     elsif params[:sidx] == "people_name"
   #        order_by "peoples.firstname #{params[:sord]}, people.lastname #{params[:sord]}"
   #     else
   #        order_by "#{params[:sidx]} #{params[:sord]}"
   #     end
   # end

    
  #  respond_to do |format|
  #  format.html # index.html.erb
  #    format.xml  { render :xml => @oligo_sequences } 
  #    format.json { render :json => oligo_sequences.to_jqgrid_json(
  #          [:id, "act", :code, "verbose_me", "dna_ellipsis", "partner_name", "people_name", :taxonomy_name, :taxonomy_id, :available, "edit"],
  #          params[:page], params[:rows], oligo_sequences.total_entries) }			

  #  end


    index_columns ||= [:id, :act, :code, :verbose_me, :dna_ellipsis, :partner_name, :people_name, :taxonomy_name, :taxonomy_id, :available, :edit]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @oligo_sequences=OligoSequence.paginate(conditions)
    total_entries=@oligo_sequences.total_entries
    
    respond_with(@oligo_sequences) do |format|
      format.json { render :json => @oligo_sequences.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end

  end

  # GET /oligo_sequences/1
  # GET /oligo_sequences/1.xml
  def show
    @oligo_sequence = OligoSequence.find(params[:id])
    @title = "Oligo sequence"
    #@pt = Partner.find(@oligo_sequence.partner_id)
    #<%=h @pt.name %>
    #@taxo = Name.find(@oligo_sequence.tax_id_id)
    #<%=h @taxo.verbose_me %>

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oligo_sequence }
    end
  end

  # GET /oligo_sequences/new
  # GET /oligo_sequences/new.xml
  def new
   
   logger.debug "::::::::::::::::::::Oligo Sequence new (" + current_user.name + "):::::::::::::::::::: "
    @oligo_sequence = OligoSequence.new
    @title = "Oligo sequence"

    @pt = get_partner
    unless @pt.nil?
      
      @oligo_sequence.partner_id = @pt.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @oligo_sequence }
    end
  end

  # GET /oligo_sequences/1/edit
  def edit
    @oligo_sequence = OligoSequence.find(params[:id])
    @title = "oligo sequence"

    @pt = Partner.find(@oligo_sequence.partner_id)
    @peo = Person.find(@oligo_sequence.people_id)

    @tree2 = ""
    #<pre id="resbio2"><%= @tree2 %></pre> <br />
    #@tree3 =  Bio::NCBI::REST::ESearch.taxonomy('tardig%')
    #@tree =  Bio::NCBI::REST::EFetch.taxonomy(12475)
    if not @oligo_sequence.taxonomy_id.nil?
    #    @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(265554, 'xml')
    #else
        @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(@oligo_sequence.taxonomy_id, 'xml')
    end
  end

  # POST /oligo_sequences
  # POST /oligo_sequences.xml
  def create
    
  logger.debug "::::::::::::::::::::Oligo Sequence create action (" + current_user.name + "):::::::::::::::::::: "

    @oligo_sequence = OligoSequence.new(params[:oligo_sequence])
    @title = "oligo sequence"

    @oligo_sequence.dna_sequence = @oligo_sequence.dna_sequence.upcase

    @asso = PartnerPerson.find(:first, 
        :conditions => [ "person_id = ? AND partner_id = ?", @oligo_sequence.people_id, @oligo_sequence.partner_id])
    unless @asso.nil?
      #set the selected item
      @oligo_sequence.partner_people_id = @asso.id
    end

    respond_to do |format|
      if @oligo_sequence.save
        format.html {  flash[:notice] = 'OligoSequence is successfully created. Click on the "+" sign on individual row, to check, which microarray experiments have utilized your oligo!!! ' 
                    redirect_to :action => "index"}
        format.xml  { render :xml => @oligo_sequence, :status => :created, :location => @oligo_sequence }
      else

        @pt = get_partner
        unless @pt.nil?
          #set the selected item
          @oligo_sequence.partner_id = @pt.id
        end

        format.html { render :action => "new" }
        format.xml  { render :xml => @oligo_sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /oligo_sequences/1
  # PUT /oligo_sequences/1.xml
  def update
    @oligo_sequence = OligoSequence.find(params[:id])
    @title = "oligo sequence"

    if !params[:oligo_sequence][:dna_sequence].nil?
        params[:oligo_sequence][:dna_sequence] = params[:oligo_sequence][:dna_sequence].upcase
    end
    respond_to do |format|
      if @oligo_sequence.update_attributes(params[:oligo_sequence])
        format.html { redirect_to(@oligo_sequence, :notice => 'OligoSequence was successfully updated.') }
        format.xml  { head :ok }
      else

        @pt = Partner.find(@oligo_sequence.partner_id)
        @peo = Person.find(@oligo_sequence.people_id)
        if @oligo_sequence.taxonomy_id.nil?
            @tree =  Bio::NCBI::REST::EFetch.taxonomy(42241)
            @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(42241, 'xml') #265554, 'xml')
        else
            @tree =  Bio::NCBI::REST::EFetch.taxonomy(@oligo_sequence.taxonomy_id)
            @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(@oligo_sequence.taxonomy_id, 'xml')
        end

        format.html { render :action => "edit" }
        format.xml  { render :xml => @oligo_sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /oligo_sequences/1
  # DELETE /oligo_sequences/1.xml
  def destroy
    @oligo_sequence = OligoSequence.find(params[:id])
    @oligo_sequence.destroy
    @title = "oligo sequence"

    respond_to do |format|
      format.html { redirect_to(oligo_sequences_url) }
      format.xml  { head :ok }
    end
  end

  def shoot    

    @oligo_sequence = OligoSequence.find(params[:id])
    @oligo_sequence.txonomy_id.destroy
    @oligo_sequence.txonomy_name.destroy

    respond_to do |format|
      format.html { redirect_to(oligo_sequences_url) }
      format.xml  { head :ok }
    end
  end



  def export_to_csv      
    data = params['data'].split(',')
    @oligos = OligoSequence.find(:all, :conditions => [ "id IN (?)", data])   
    send_data(export_oligos(@oligos),
    :type => 'text/csv;charset=utf-8;header=present', 
    :disposition => 'attachment')
  end

  def export_all
    @oligos = OligoSequence.all
    send_data(export_oligos(@oligos), 
    :type => 'text/csv;charset=utf-8;header=present', 
    :disposition => "attachment;filename=Oligo_data_#{Time.now.strftime('%d%m%y-%H%M')}.csv")
  end

  def export_all_xls
    @oligos = OligoSequence.all
    send_data(export_oligos(@oligos), 
    :type => 'xls;charset=utf-8;header=present',
    :disposition => "attachment;filename=All_oligo_data_#{Time.now.strftime('%d%m%y-%H%M')}.xls")
  end


  private

    def export_oligos(obj)
        file = CSV.generate do |line|
        oligos = OligoSequence.all

		if oligos.size == obj.size
		   line << ["List of all oligos available in database"] 
		else		   
                   line << ["Selected oligo data exported on #{Time.now.strftime('%d/%m/%y-%H:%M')}"]
		end
        
        line << ["ID","Details","PartnerCode","DNASequence","Date","Partner","Person","TaxName","TaxID"]
        obj.each do |entry|                
        line << [entry.id, entry.description, entry.code, entry.dna_ellipsis, entry.oligoDate, entry.name, entry.people_name, entry.taxonomy_name, entry.taxonomy_id ]
         end 
       end 
      return file
    end

    def correct_user
      @oligo = OligoSequence.find(params[:id])
      @partner = Partner.find(@oligo.partner_id)
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the oligo sequence can modify it."
      redirect_to(oligo_sequences_path)
    end

    


end




        
























