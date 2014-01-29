class GalBlocksController < AuthController
  
 respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :gal_blocks,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end


  def post_data
    message=""
    gal_block_params = { :id => params[:id],:block_number => params[:block_number],:xOrigin => params[:xOrigin],:yOrigin => params[:yOrigin],:feature_diameter => params[:feature_diameter],:xFeatures => params[:xFeatures],:xSpacing => params[:xSpacing],:yFeatures => params[:yFeatures],:ySpacing => params[:ySpacing],:gal_header_id => params[:gal_header_id],:microarraygal_id => params[:microarraygal_id] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        gal_block = GalBlock.create(gal_block_params)
        message << ('add ok') if gal_block.errors.empty?
      end
      
    when 'edit'
      gal_block = GalBlock.find(params[:id])
      message << ('update ok') if gal_block.update_attributes(gal_block_params)
    when 'del'
      GalBlock.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      gal_blocks = GalBlock.all
      gal_blocks.each do |gal_block|
        gal_block.position = params['ids'].index(gal_block.id.to_s) + 1 if params['ids'].index(gal_block.id.to_s) 
        gal_block.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (gal_block && gal_block.errors).blank?  
      gal_block.errors.entries.each do |error|
        message << "<strong>#{GalBlock.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end



  def index
	  #@gal_blocks = GalBlock.all
            @title = "GAL file blocks information"
     #    gal_blocks = GalBlock.find(:all) do
     #      
     #     if params[:_search] == "true"
     #	     microarraygal.id =~ "%#{params[:gal_id]}%" if params[:gal_id].present?
     #	  end
     #
     #	       paginate :page => params[:page], :per_page => params[:rows]
     #	       order_by "#{params[:sidx]} #{params[:sord]}" 
     # 
     #     if params[:sidx] == "gal_id"
     #	     order_by "microarraygals.id #{params[:sord]}"   
     #     end  
     #
     # 
     # end

     #  respond_to do |format|
     #   format.html 
     #   format.json { render :json => gal_blocks.to_jqgrid_json([:id,"act","gal_id","block","x_origin","y_origin","featureDiameter","x_feature","x_spacing","y_feature","y_spacing","block_upload_date","edit"], params[:page], params[:rows], gal_blocks.total_entries) }			
    #end

   index_columns ||= [:id,:act,:gal_id,:block,:x_origin,:y_origin,:featureDiameter,:x_feature,:x_spacing,:y_feature,:y_spacing,:block_upload_date,:edit]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @gal_blocks=GalBlock.paginate(conditions)
    total_entries=@gal_blocks.total_entries
    
    respond_with(@gal_blocks) do |format|
      format.json { render :json => @gal_blocks.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end

  end

  def show
	   @gal_block = GalBlock.find(params[:id])

	    respond_to do |format|
	    format.html # show.html.erb
	    format.xml  { render :xml => @gal_block }
	  end
  end

  def edit
            @gal_block = GalBlock.find(params[:id])
  end

  def update
	    @gal_block = GalBlock.find(params[:id])

	    respond_to do |format|
	      if @gal_block.update_attributes(params[:gal_block])
		format.html { redirect_to(@gal_block, :notice => 'GalBlock was successfully updated.') }
		format.xml  { head :ok }
	      else
		format.html { render :action => "edit" }
		format.xml  { render :xml => @gal_block.errors, :status => :unprocessable_entity }
	      end
	    end
  end


  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to gal_blocks_path
    else

        @mg = Microarraygal.find(:first, :conditions => [ "gal_block_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @gal_block = GalBlock.find(params[:id])
        @gal_block.destroy

        respond_to do |format|
          format.html { redirect_to(gal_block_url) }
          format.xml  { head :ok }
        end
    end
  end

end
