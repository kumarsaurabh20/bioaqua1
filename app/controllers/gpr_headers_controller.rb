class GprHeadersController < AuthController

  respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :gpr_headers,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end



  def post_data
    message=""
    gpr_header_params = { :id => params[:id],:gprVersion => params[:gprVersion],:number_data_column => params[:number_data_column],:gprtype => params[:gprtype],:datetime => params[:datetime],:settings => params[:settings],:galfile => params[:galfile],:pixelsize => params[:pixelsize],:wavelengths => params[:wavelengths],:imagefiles => params[:imagefiles],:normalizationmethod => params[:normalizationmethod],:normalizationfactors => params[:normalizationfactors],:jpegimage => params[:jpegimage],:stddev => params[:stddev],:ratioformulations => params[:ratioformulations],:featuretype => params[:featuretype],:barcode => params[:barcode],:backgroundsubtraction => params[:backgroundsubtraction],:imageorigin => params[:imageorigin],:jpegorigin => params[:jpegorigin],:creator => params[:creator],:scanner => params[:scanner],:focusposition => params[:focusposition],:temp => params[:temp],:linesavg => params[:linesavg],:comment => params[:comment],:pmtgain => params[:pmtgain],:scanpower => params[:scanpower],:laserpower => params[:laserpower],:filters => params[:filters],:scanregion => params[:scanregion],:supplier => params[:supplier],:microarraygpr_id => params[:microarraygpr_id] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        gpr_header = GprHeader.create(gpr_header_params)
        message << ('add ok') if gpr_header.errors.empty?
      end
      
    when 'edit'
      gpr_header = GprHeader.find(params[:id])
      message << ('update ok') if gpr_header.update_attributes(gpr_header_params)
    when 'del'
      GprHeader.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      gpr_headers = GprHeader.all
      gpr_headers.each do |gpr_header|
        gpr_header.position = params['ids'].index(gpr_header.id.to_s) + 1 if params['ids'].index(gpr_header.id.to_s) 
        gpr_header.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (gpr_header && gpr_header.errors).blank?  
      gpr_header.errors.entries.each do |error|
        message << "<strong>#{GprHeader.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end


  def index
#    @gpr_headers = GprHeader.all
    @title = "GPR file header information"
#           gpr_headers = GprHeader.find(:all) do

              # if params[:_search] == "true"
		#	   microarraygpr.id =~ "%#{params[:gal_id]}%" if params[:gal_id].present?
		#	   gal_row_count =~ "%#{params[:row_count]}%" if params[:row_count].present?
		#	   gal_column_count =~ "%#{params[:column_count]}%" if params[:column_count].present?
                 #          block_count =~ "%#{params[:bcount]}%" if params[:bcount].present?
                  #         block_type =~ "%#{params[:block_type]}%" if params[:block_type].present?
                   #        supplier =~ "%#{params[:company]}%" if params[:company].present?
			   
		#	end

#	       paginate :page => params[:page], :per_page => params[:rows]
#	       order_by "#{params[:sidx]} #{params[:sord]}" 

		 #      if params[:sidx] == "gal_id"
		#	  order_by "microarraygals.id #{params[:sord]}"
		 #	  order_by "gal_row_count #{params[:sord]}"
		  #     elsif params[:sidx] == "column_count"
		#	  order_by "gal_column_count #{params[:sord]}"
                 #      elsif params[:sidx] == "bcount"
		#	  order_by "block_count #{params[:sord]}"
                 #      elsif params[:sidx] == "block_type"
		#	  order_by "block_type #{params[:sord]}"
                 #      elsif params[:sidx] == ":company"
		#	  order_by "supplier #{params[:sord]}"    
		 #      end  

#          end

#        respond_to do |format|
#        format.html 
#        format.json { render :json => gpr_headers.to_jqgrid_json([:id,"act",:microarraygpr_id,:gprVersion,:gprtype,:datetime,:settings,:pixelsize,:wavelengths, 
#:normalizationmethod,:normalizationfactors, :stddev, :ratioformulations,:featuretype, :barcode, :backgroundsubtraction, 
#:imageorigin, :jpegorigin, :creator, :scanner, :focusposition, :temp, :linesavg, :comment, :pmtgain, 
#:scanpower, :laserpower, :filters, :scanregion, :supplier, :created_at, "edit"], params[:page], params#[:rows], gpr_headers.total_entries) }			
#    end


  index_columns ||= [:id,:act,:microarraygpr_id,:gprVersion,:gprtype,:datetime,:settings,:pixelsize,:wavelengths, 
:normalizationmethod,:normalizationfactors, :stddev, :ratioformulations,:featuretype, :barcode, :backgroundsubtraction, 
:imageorigin, :jpegorigin, :creator, :scanner, :focusposition, :temp, :linesavg, :comment, :pmtgain, 
:scanpower, :laserpower, :filters, :scanregion, :supplier, :created_at, :edit]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @gpr_headers=GprHeader.paginate(conditions)
    total_entries=@gpr_headers.total_entries
    
    respond_with(@gpr_headers) do |format|
      format.json { render :json => @gpr_headers.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end

  end



# GET /gpr_header/1
  # GET /gpr_header/1.xml
  def show
    @gpr_header = GprHeader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gpr_header }
    end
  end

  # GET /gpr_header/1/edit
  def edit
    @gpr_header = GprHeader.find(params[:id])
  end

  # PUT /gpr_header/1
  # PUT /gpr_header/1.xml
  def update
    @gpr_header = GprHeader.find(params[:id])

    respond_to do |format|
      if @gpr_header.update_attributes(params[:gpr_header])
        format.html { redirect_to(@gpr_header, :notice => 'GprHeader is successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gpr_header.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gpr_header/1
  # DELETE /gpr_header/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to gpr_header_path
    else

        @mg = Microarraygpr.find(:first, :conditions => [ "gpr_header_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @gpr_header = GprHeader.find(params[:id])
        @gpr_header.destroy

        respond_to do |format|
          format.html { redirect_to(gpr_header_url) }
          format.xml  { head :ok }
        end
    end
  end
















end
