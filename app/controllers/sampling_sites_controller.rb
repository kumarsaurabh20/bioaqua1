class SamplingSitesController < AuthController

  respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :sampling_sites,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end


  # GET /sampling_sites
  # GET /sampling_sites.xml

  #before_filter :find_water_use, :only => [:show, :edit, :update]
  #private def find_water_use
  # #Model name
  # @wu = WaterUse.find(params[:water_uses_id])
  #end


  def post_data
    message=""
    sampling_site_params = { :id => params[:id],:code => params[:code],:name => params[:name],:altitude_types_id => params[:altitude_types_id],:catchment_areas_id => params[:catchment_areas_id],:size_typologies_id => params[:size_typologies_id],:geologies_id => params[:geologies_id],:depth_id => params[:depth_id],:link => params[:link],:water_type_id => params[:water_type_id],:water_use_id => params[:water_use_id],:land_use_mapping_id => params[:land_use_mapping_id],:geo_id => params[:geo_id],:geos_id => params[:geos_id],:geos_type => params[:geos_type],:note => params[:note],:distance_to_source => params[:distance_to_source] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        sampling_site = SamplingSite.create(sampling_site_params)
        message << ('add ok') if sampling_site.errors.empty?
      end
      
    when 'edit'
      sampling_site = SamplingSite.find(params[:id])
      message << ('update ok') if sampling_site.update_attributes(sampling_site_params)
    when 'del'
      SamplingSite.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      sampling_sites = SamplingSite.all
      sampling_sites.each do |sampling_site|
        sampling_site.position = params['ids'].index(sampling_site.id.to_s) + 1 if params['ids'].index(sampling_site.id.to_s) 
        sampling_site.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (sampling_site && sampling_site.errors).blank?  
      sampling_site.errors.entries.each do |error|
        message << "<strong>#{SamplingSite.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end


  def index
    #@sampling_sites = SamplingSite.all
    @title = "Sampling sites"
    

    #@wu = WaterUse.find(@sampling_site.water_uses_id)
    #@wt = WaterType.find(@sampling_site.water_types_id)
    #@lum = LandUseMapping.find(@sampling_site.land_use_mappings_id)
    #@g = Geo.find(@sampling_site.geos_id)
    #sampling_sites = SamplingSite.find(:all, :joins => [:water_use, :water_type, :geo, :land_use_mapping]) do
    #sampling_sites = SamplingSite.find(:all, :joins => [:geo]) do
#Mysql::Error: Unknown column 'sampling_sites.geo_id' in 'on clause': SELECT `sampling_sites`.* FROM `sampling_sites` INNER JOIN `geos` ON `geos`.id = `sampling_sites`.geo_id LIMIT 0, 20
    #water_types_id water_uses_id land_use_mappings_id geos_id
    
   #sampling_sites = SamplingSite.find(:all) do
   #     if params[:_search] == "true"
   #         code =~ "%#{params[:code]}%" if params[:code].present?
   #         name =~ "%#{params[:name]}%" if params[:name].present?
   #         water_type.name =~ "%#{params[:w_type_name]}%" if params[:w_type_name].present?
   #        water_use.name =~ "%#{params[:w_use_name]}%" if params[:w_use_name].present?
   #         land_use_mapping.name =~ "%#{params[:land_name]}%" if params[:land_name].present?
   #         geo.name =~ "%#{params[:geo_name]}%" if params[:geo_name].present?
   #     end
   #     paginate :page => params[:page], :per_page => params[:rows]
   #     #for sort use join condition. Not requires by search because of reflection model
   #     if params[:sidx] == "w_use_name"
   #         order_by "water_uses.name #{params[:sord]}"
   #     elsif params[:sidx] == "w_type_name"
   #         order_by "water_types.code #{params[:sord]}"
   #     elsif params[:sidx] == "land_name"
   #         order_by "land_use_mappings.name #{params[:sord]}"
   #     elsif params[:sidx] == "geo_name"
   #         order_by "geos.name #{params[:sord]}"
   #     else
   #         order_by "#{params[:sidx]} #{params[:sord]}"
   #     end
   #end

    #respond_to do |format|
    #    format.html # index.html.erb
        #format.xml { render :xml => @sampling_sites }
    #    format.json { render :json => sampling_sites.to_jqgrid_json(
    #        [:id, "act",:code,:name,:w_use_name,:w_type_name,"land_name","geo_name","edit"],
    #        params[:page], params[:rows], sampling_sites.total_entries) }	
    #end


    index_columns ||= [:id, :act, :code, :name, :w_use_name, :w_type_name, :land_name, :geo_name, :edit]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @sampling_sites=SamplingSite.paginate(conditions)

    total_entries=@sampling_sites.total_entries

    @sites = SamplingSite.all
    @map = GMap.new("map_div") 
    @map.control_init(:large_map => true,:map_type => true) 
    @map.center_zoom_init([46.95, 7.416667],4) 
    @map.overlay_init(GMarker.new([75.6,-42.467],:title => "Hello", :info_window => "Info! Info!")) 


    @sites = SamplingSite.all
    
     
    for ss in @sites
        #g = ss.geo
        g = Geo.find(ss.geo_id) 
        marker = GMarker.new([g.lat, g.lon],:title => g.name, :info_window => g.verbose_me)
        @map.overlay_init(marker)

    end
    
    respond_with(@sampling_sites) do |format|
      format.json { render :json => @sampling_sites.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end
  

  end


  # GET /sampling_sites/1
  # GET /sampling_sites/1.xml
  def show
    @sampling_site = SamplingSite.find(params[:id])
    if @sampling_site.nil?
        redirect_to :action => "index"
    end
    @title = "Sampling sites"
    @wu = WaterUse.find(@sampling_site.water_use_id)
    @wt = WaterType.find(@sampling_site.water_type_id)
    @lum = LandUseMapping.find(@sampling_site.land_use_mapping_id)
    @geo = Geo.find(@sampling_site.geo_id)

    @at = AltitudeType.find(@sampling_site.altitude_types_id)
    @ca = CatchmentArea.find(@sampling_site.catchment_areas_id)
    @geol = Geology.find(@sampling_site.geologies_id)
    @depth = Depth.find(@sampling_site.depth_id)
    @st = SizeTypology.find(@sampling_site.size_typologies_id)

    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([@geo.lat, @geo.lon], 4)
     
    marker = GMarker.new([@geo.lat, @geo.lon],
      :title => @geo.name, :info_window => @geo.verbose_me)
    @map.overlay_init(marker)

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @sampling_site }
    end
  end

  # GET /sampling_sites/new
  # GET /sampling_sites/new.xml
  def new
    @sampling_site = SamplingSite.new
    @title = "Sampling site"

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @sampling_site }
    end
  end

  # GET /sampling_sites/1/edit
  def edit
    @sampling_site = SamplingSite.find(params[:id])
    @title = "Sampling site"
  end

  # POST /sampling_sites
  # POST /sampling_sites.xml
  def create
    @sampling_site = SamplingSite.new(params[:sampling_site])
    @title = "Sampling site"

    respond_to do |format|
      if @sampling_site.save
        format.html { redirect_to(@sampling_site, :notice => 'SamplingSite was successfully created.') }
        format.xml { render :xml => @sampling_site, :status => :created, :location => @sampling_site }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @sampling_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sampling_sites/1
  # PUT /sampling_sites/1.xml
  def update
    @sampling_site = SamplingSite.find(params[:id])
    @title = "Sampling site"

    respond_to do |format|
      if @sampling_site.update_attributes(params[:sampling_site])
        format.html { redirect_to(@sampling_site, :notice => 'SamplingSite was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @sampling_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sampling_sites/1
  # DELETE /sampling_sites/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to sampling_sites_path
    else

        @title = "Sampling site"

        @ws = Sampling.find(:first, :conditions => [ "sampling_site_id = ?", params[:id]])
        if !@ws.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries (Water sample) in the system..."
          redirect_to :action => "index"
          return
        end

        @sampling_site = SamplingSite.find(params[:id])
        flash[:notice] = "Deleted sampling site: " + @sampling_site.verbose_me
        @sampling_site.destroy

        respond_to do |format|
          format.html { redirect_to(sampling_sites_url) }
          format.xml { head :ok }
        end
    end
  end
end


#<table>
# <tr>
# <th>Code</th>
# <th>Name</th>
# <th>Water type</th>
# <th>Water use</th>
# <th>Land use</th>
# <th>Geo</th>
# </tr>

#<% @sampling_sites.each do |sampling_site| %>
# <tr>
# <td><%=h sampling_site.code %></td>
# <td><%=h sampling_site.name %></td>
# <td><%=h WaterUse.find(sampling_site.water_uses_id).name %></td>
# <td><%=h WaterType.find(sampling_site.water_types_id).name %></td>
# <td><%=h LandUseMapping.find(sampling_site.land_use_mappings_id).name %></td>
# <td><%=h Geo.find(sampling_site.geos_id).name %></td>
# <td><%= link_to 'Show', sampling_site %></td>
# <td><%= link_to 'Edit', edit_sampling_site_path(sampling_site) %></td>
# <td><%= link_to 'Delete', sampling_site, :confirm => 'Are you sure?', :method => :delete %></td>
# </tr>
#<% end %>
#</table>


#<script type="text/javascript">
#function handleSelection(id) {
# alert('ID selected %>: ' + id);
#}
#</script>
#{ :selection_handler => "handleSelection", :direct_selection => true, :edit => true }





