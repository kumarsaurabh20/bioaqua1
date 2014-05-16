class SamplingsController < AuthController
  respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :samplings,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end


  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update, :delete, :destroy]


 def post_data
    message=""
    sampling_params = { :id => params[:id],:code => params[:code],:volume => params[:volume],:sampling_site_id => params[:sampling_site_id],:samplingDate => params[:samplingDate],:note => params[:note],:air_temperature => params[:air_temperature],:moisture => params[:moisture],:pressure => params[:pressure],:windSpeed => params[:windSpeed],:windDirection => params[:windDirection],:waterFlow => params[:waterFlow],:lightIntensity => params[:lightIntensity],:rainfallEvents => params[:rainfallEvents],:depth => params[:depth],:turbidity => params[:turbidity],:salinity => params[:salinity],:tidalRange => params[:tidalRange],:operators => params[:operators],:water_temperature => params[:water_temperature],:conductivity => params[:conductivity],:phosphates => params[:phosphates],:nitrates => params[:nitrates],:ph => params[:ph],:nitrogen => params[:nitrogen],:bod5 => params[:bod5],:cod => params[:cod],:h2osat => params[:h2osat],:sampling_equipments_id => params[:sampling_equipments_id],:storage => params[:storage] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        sampling = Sampling.create(sampling_params)
        message << ('add ok') if sampling.errors.empty?
      end
      
    when 'edit'
      sampling = Sampling.find(params[:id])
      message << ('update ok') if sampling.update_attributes(sampling_params)
    when 'del'
      Sampling.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      samplings = Sampling.all
      samplings.each do |sampling|
        sampling.position = params['ids'].index(sampling.id.to_s) + 1 if params['ids'].index(sampling.id.to_s) 
        sampling.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
  
    unless (sampling && sampling.errors).blank?  
      sampling.errors.entries.each do |error|
        message << "<strong>#{Sampling.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end

 end


  # GET /samplings
  # GET /samplings.xml
  def index
    #@samplings = Sampling.all
    @title = "List of samplings"

    #samplings = Sampling.find(:all, :joins=> [:sampling_equipments, :partner, :sampling_site]) do
    #samplings = Sampling.find(:all, :joins=> [:partner, :sampling_site]) do
    #    if params[:_search] == "true"
    #        volume =~ "%#{params[:volume]}%" if params[:volume].present?
    #        code =~ "%#{params[:code]}%" if params[:code].present?
    #        sampling_site.name =~ "%#{params[:site_name]}%" if params[:site_name].present?
    #        sampling_site.code =~ "%#{params[:site_name]}%" if params[:site_name].present?
    #        partner.code =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
    #        #KAPPAO because it done an AND operator between ID and CODE
    #        #partner.id =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
    #        sampling_equipment.name =~ "%#{params[:sampling_equipment_name]}%" if params[:sampling_equipment_name].present?
    #  end
    #paginate :page => params[:page], :per_page => params[:rows]      
    #    if params[:sidx] == "site_name"
    #        order_by "sampling_sites.name #{params[:sord]}, sampling_sites.code #{params[:sord]}"
    #
    #    elsif params[:sidx] == "partner_name"
    #        order_by "partners.code #{params[:sord]}"
    #    elsif params[:sidx] == "code"
    #        order_by "samplings.code #{params[:sord]}"
    #    elsif params[:sidx] == "sampling_equipment_name"
    #        order_by "sampling_equipments.name #{params[:sord]}"
    #    else
    #        order_by "#{params[:sidx]} #{params[:sord]}"
    #    end
    #end

    #respond_to do |format|
    #    format.html # index.html.erbs directly,
    #    #format.xml  { render :xml => @samplings }
    #    format.json { render :json => samplings.to_jqgrid_json(
    #        [:id, "act",:code,:site_name,:volume,"partner_name", "sampling_equipment_name","edit"],
    #        params[:page], params[:rows], samplings.total_entries) }			
    #end


    index_columns ||= [:id, :act,:code,:site_name,:volume, :partner_name,:sampling_equipment_name,:edit]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10
    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @samplings=Sampling.paginate(conditions)
    total_entries=@samplings.total_entries
    
    respond_with(@samplings) do |format|
      format.json { render :json => @samplings.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end
 end

  # GET /samplings/1
  # GET /samplings/1.xml
  def show
    @sampling = Sampling.find(params[:id])
    @title = "Sampling"

    if @sampling.nil?
        redirect_to :action => "index"
    end
    @pt = Partner.find(@sampling.partner_id)
    @ss = SamplingSite.find(@sampling.sampling_site_id)
    if @ss.nil?
      flash.now[:error] = "No sampling sites found! create some..."
      redirect_to :action => "index"
    end

    @fs = FilterSample.all(:conditions => ['sampling_id = ?', @sampling.id ])

    begin
        #if !@sampling.sampling_equipments_id?
        @se = SamplingEquipment.find(@sampling.sampling_equipments_id)
        if @se.nil?
            @se = SamplingEquipment.first
        end
    rescue Exception => e
        @se = SamplingEquipment.first
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sampling }
    end
  end

  # GET /samplings/new
  # GET /samplings/new.xml
  def new
    @sampling = Sampling.new
    @title = "Sampling"

    @partners = Partner.find(:all)
    @pt = get_partner
    unless @pt.nil?
      #set the selected item
      @sampling.partner_id = @pt.id
    end

    #@codtypes = CodeType.all()
    @codegen = get_code(@pt, nil, nil)

    #used for NESTED Model
    #pre-build another attribute while loading the form
    @wf = Wfilter.all()
    #count = @wf.size
    #count.times { @sampling.filter_samples.build } 

    10.times {@sampling.filter_samples.build}    

    @attr_index = 1
    
    @ss_c = SamplingSite.count()
    if @ss_c.nil? or @ss_c == 0
      flash[:error] = "No sampling sites found! create first someone..."
      redirect_to :action => "index"
      return
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sampling }
    end
  end

  # POST /samplings
  # POST /samplings.xml
  def create
    @sampling = Sampling.new(params[:sampling])

    #used for NESTED Model
    @wf = Wfilter.all()

    @valid = false
    if @sampling.sampling_site.nil?
      flash.now[:error] = "No sampling site set for this sampling"
      @valid = true
    end
    if @sampling.partner.nil?
      flash.now[:error] = "No partner found for this sampling"
      @valid = true
    end

    if @valid
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @sampling.errors, :status => :unprocessable_entity }
      end
    end

    @pt = get_partner
    @sampling.code = get_code(@pt, @sampling.samplingDate, nil)

    @title = "Sampling"
    
    respond_to do |format|
      if @sampling.save

        #Change the child code attribute here because the parent code is yet created
        @fs = FilterSample.count(:all, :conditions => ['sampling_id = ' + @sampling.id.to_s ])
        print ('----Change childs attributes here -------- parent (id-'+@sampling.id.to_s+') code is: '+@sampling.code+'. Childs are -['+@fs.to_s+']-\n' )

        unless @fs.nil? and @fs > 0
            #generate the Microaqua code for all child yet created to this parent
            @fs = FilterSample.all(:conditions => ['sampling_id = ' +@sampling.id.to_s ])
            @fs.each_with_index do |child, index|
                print('----Change childs Old code: (-%s)\n', child.code)
                #child.code = child.code[0..11] + ("-F%02d" % (index + 1))
                child.code = @sampling.code + ("-F%02d" % (index + 1))
                print('----Change childs New code: (-%s)\n' , child.code)
                child.save()
            end 
         end 

        format.html { 
        flash[:notice] = 'Sampling was successfully created.'
        redirect_to :action => "index"  }      
      else
        #@partners = Partner.find(:all)
        @codegen = @sampling.code
        @attr_index = 1
        @pt = get_partner
        format.html { redirect_to :action => :index } 
        flash[:notice] = "Sampling was not created!!" 
      end
    end
  end 

# GET /samplings/1/edit
  def edit
    @sampling = Sampling.find(params[:id])
    @title = "Sampling"
    #used for NESTED Model
    @wf = Wfilter.all()    
    #@fs = FilterSample.all(:conditions => ['sampling_id = ' + @sampling.id.to_s ]) 

 end

  # PUT /samplings/1
  # PUT /samplings/1.xml
  def update
    @sampling = Sampling.find(params[:id])
    @title = "Sampling"
    count = @sampling.num_filter
    #@is_Auth = is_current_user(@sampling.partner_id)  --> Yet done in def correct_user

    #used for NESTED Model
    @wf = Wfilter.all()
    @sampling.assign_attributes(params[:sampling])

    respond_to do |format|
      if @sampling.update_attributes(params[:sampling])
        format.html { redirect_to(@sampling, :notice => 'Sampling was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sampling.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /samplings/1
  # DELETE /samplings/1.xml
  def destroy
#    if !signed_in_and_master?
#      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
#      redirect_to samplings_path
#    else

    @title = "Sampling"

    #Load data and ensure that no children data are connected
    #@ws = Sampling.find(:first, :conditions => [ "sampling_site_id = ?", params[:id]])
    #if !@ws.nil?
    #  flash[:error] = "This entry cannot be deleted until used by another entries (Water sample) in the system..."
    #  redirect_to :action => "index"
    #  return
    #end
    # --> Cascading delete all chidren FilterSample 
    # --> has_many :filter_samples, :dependent => :destroy, :class_name => 'FilterSample'

    @sampling = Sampling.find(params[:id])
    flash[:notice] = "Deleted water sample: " + @sampling.verbose_me
    @sampling.destroy

    respond_to do |format|
      format.html { redirect_to(samplings_url) }
      format.xml  { head :ok }
    end

    #end
  end

  private

    def correct_user
      @sampling = Sampling.find(params[:id])
      @ss = SamplingSite.find(@sampling.sampling_site_id)
      @partner = Partner.find(@sampling.partner_id)
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      reroute() unless current_user?(@user) or signed_in_and_master?
    end

    def reroute()
      flash[:notice] = "Only the partner who create the sampling can modify it."
      redirect_to(samplings_path)
    end

    def get_code(partner, pdate, ptype)
      @codegen = ""
      if partner.nil? and not signed_in_and_master?
        return "P??"
      end
      @pid = 1
      unless partner.nil?
        @pid = partner.id
        #2 digits = Nation IT
        #@codegen += partner.country.code.upcase
        #3 or 2 digits -= Partner number, P5 OR P
        @codegen += "P"
        @codegen += "%02d" % partner.fp7_Number
        @codegen += "-"
      else
        if signed_in_and_master?
          @codegen += "ADM"
        else
          @codegen += "P??"
        end
      end

      #4 or 3 = date month and years 1211 OR 121
      #2011 create increment number by registered date
      if pdate.nil?
        #only for generate sample code in the new view (but it is hide)
        pdate = Date.today
      end

      unless pdate.nil?
        #time = Time.new
        #@codegen += time.month.to_s + time.year.to_s
        @codegen += pdate.strftime("%y%m%d")
        @codegen += "-"
      end

#      #3 digit = Sample,  001
#      #@cnt = Sampling.count()
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['partner_id = ' + @pid.to_s ])
#      #@lst = Sampling.last
      #2011 create increment number by registered date and partner
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['partner_id =  ? AND samplingDate >= ? AND samplingDate < ? ',  @pid.to_s, Date.today, 1.day.from_now.to_date ])
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['code LIKE ? ', '%'+@codegen+'%'])
      @cnt_objs = Sampling.all(:select => "DISTINCT code", :conditions => ['code LIKE ? ', '%'+@codegen+'%'], :order => 'code DESC')
      @cnt = 1 
      if not @cnt_objs.nil? 
          @cnt_obj = @cnt_objs[0] 
          if not @cnt_obj.nil? 
             #P03-110129-xx
             if not @cnt_obj.code.nil? 
                @end_str = @cnt_obj.code[11..12]
                if not @end_str.nil? 
                    @end = @end_str.to_i
                    @cnt = @end + 1
                 else 
                    @cnt = '0'
                 end
             else 
                @cnt = '0'
             end
          end
      end

      @codegen += "%02d" % @cnt

      # 1 digit organisms b (bacteria) (PTR5)
      # or 1 digit (PTR4) water tyrpe R (river) Lake etc..
      unless ptype.nil?
        @codegen += ptype.to_s
#      else
#        @codegen += "?"
      end

      return @codegen
    end

end


#INDEX
#<table>
#  <tr>
#    <th>Sampling site</th>
#    <th>Volume (lt)</th>
#    <th>Code</th>
#    <th>Partner</th>
#  </tr>
#<% @samplings.each do |sampling| %>
#  <tr>
#    <td><%=h SamplingSite.find(sampling.sampling_site_id).verbose_me %></td>
#    <td><%=h sampling.volume %></td>
#    <td><%=h sampling.code %></td>
#    <td><%=h Partner.find(sampling.partner_id).verbose_me %></td>
#    <td><%= link_to 'Show', sampling %></td>
#    <% if auth_user(sampling.partner_id) or signed_in_and_master? %>
#      <td><%= link_to 'Edit', edit_sampling_path(sampling) %></td>
#      <td><%= link_to 'Delete', sampling, :confirm => 'Are you sure?', :method => :delete %></td>
#    <% end %>
#  </tr>
#<% end %>
#</table>
