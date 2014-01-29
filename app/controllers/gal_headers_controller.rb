class GalHeadersController < AuthController
 
respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :gal_headers,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end


def post_data
    message=""
    gal_header_params = { :id => params[:id],:gal_version_info => params[:gal_version_info],:number_data_column => params[:number_data_column],:gal_row_count => params[:gal_row_count],:block_type => params[:block_type],:block_count => params[:block_count],:supplier => params[:supplier],:mucroarraygal_id => params[:mucroarraygal_id] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        gal_header = GalHeader.create(gal_header_params)
        message << ('add ok') if gal_header.errors.empty?
      end
      
    when 'edit'
      gal_header = GalHeader.find(params[:id])
      message << ('update ok') if gal_header.update_attributes(gal_header_params)
    when 'del'
      GalHeader.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      gal_headers = GalHeader.all
      gal_headers.each do |gal_header|
        gal_header.position = params['ids'].index(gal_header.id.to_s) + 1 if params['ids'].index(gal_header.id.to_s) 
        gal_header.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (gal_header && gal_header.errors).blank?  
      gal_header.errors.entries.each do |error|
        message << "<strong>#{GalHeader.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end 

  # GET /gal_header
  # GET /gal_header.xml
  def index
    #@gal_headers = GalHeader.all
    @title = "GAL file header information"
    #       gal_headers = GalHeader.find(:all) do
    #
    #           if params[:_search] == "true"
    #			   microarraygal.id =~ "%#{params[:gal_id]}%" if params[:gal_id].present?
	#		   gal_row_count =~ "%#{params[:row_count]}%" if params[:row_count].present?
	#		   gal_column_count =~ "%#{params[:column_count]}%" if params[:column_count].present?
         #                  block_count =~ "%#{params[:bcount]}%" if params[:bcount].present?
         #                  block_type =~ "%#{params[:block_type]}%" if params[:block_type].present?
         #                  supplier =~ "%#{params[:company]}%" if params[:company].present?
#			   
#			end
#
#	       paginate :page => params[:page], :per_page => params[:rows]
#	       order_by "#{params[:sidx]} #{params[:sord]}" 
#
#		       if params[:sidx] == "gal_id"
#			  order_by "microarraygals.id #{params[:sord]}"
#		       elsif params[:sidx] == "row_count"
#			  order_by "gal_row_count #{params[:sord]}"
#		       elsif params[:sidx] == "column_count"
#			  order_by "gal_column_count #{params[:sord]}"
#                       elsif params[:sidx] == "bcount"
#			  order_by "block_count #{params[:sord]}"
#                       elsif params[:sidx] == "block_type"
#			  order_by "block_type #{params[:sord]}"
#                       elsif params[:sidx] == ":company"
#			  order_by "supplier #{params[:sord]}"    
#		       end  
#
#          end
#
#        respond_to do |format|
#        format.html 
#        format.json { render :json => gal_headers.to_jqgrid_json([:id,"act","gal_id","version","row_count","column_count","bcount",:block_type,"company","header_upload_date","edit"], params[:page], params[:rows], gal_headers.total_entries) }			
#    end

  index_columns ||= [:id,:act,:gal_id,:version,:row_count,:column_count,:bcount,:block_type,:company,:header_upload_date,:edit]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @gal_headers=GalHeader.paginate(conditions)
    total_entries=@gal_headers.total_entries
    
    respond_with(@gal_headers) do |format|
      format.json { render :json => @gal_headers.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end

  end

  # GET /gal_header/1
  # GET /gal_header/1.xml
  def show
    @gal_header = GalHeader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gal_header }
    end
  end

  # GET /gal_header/1/edit
  def edit
    @gal_header = GalHeader.find(params[:id])
  end

  # PUT /gal_header/1
  # PUT /gal_header/1.xml
  def update
    @gal_header = GalHeader.find(params[:id])

    respond_to do |format|
      if @gal_header.update_attributes(params[:gal_header])
        format.html { redirect_to(@gal_header, :notice => 'GalHeader was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gal_header.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gal_header/1
  # DELETE /gal_header/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to gal_header_path
    else

        @mg = Microarraygal.find(:first, :conditions => [ "gal_header_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @gal_header = GalHeader.find(params[:id])
        @gal_header.destroy

        respond_to do |format|
          format.html { redirect_to(gal_header_url) }
          format.xml  { head :ok }
        end
    end
  end

end
