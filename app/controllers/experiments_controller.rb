class ExperimentsController < AuthController
   
  require 'matrix'
  require 'csv' 
  #require 'rinruby'

  respond_to :html,:json
  
  #protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :experiments,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end


  class UnknownTypeError < StandardError
  end

  class NoGprError < StandardError
  end

  before_filter :correct_user, :only => [:edit, :update, :delete, :destroy]


  def post_data
    message=""
    experiment_params = { :id => params[:id],:filter_sample_id => params[:filter_sample_id],:microarraygal_id => params[:microarraygal_id],:partner_id => params[:partner_id],:ecode => params[:ecode],:barcode => params[:barcode],:experiment_date => params[:experiment_date],:note => params[:note],:people_id => params[:people_id],:microarraygpr_id => params[:microarraygpr_id],:micro_array_image_id => params[:micro_array_image_id],:check => params[:check] }
    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        experiment = Experiment.create(experiment_params)
        message << ('add ok') if experiment.errors.empty?
      end
      
    when 'edit'
      experiment = Experiment.find(params[:id])
      message << ('update ok') if experiment.update_attributes(experiment_params)
    when 'del'
      Experiment.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      experiments = Experiment.all
      experiments.each do |experiment|
        experiment.position = params['ids'].index(experiment.id.to_s) + 1 if params['ids'].index(experiment.id.to_s) 
        experiment.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (experiment && experiment.errors).blank?  
      experiment.errors.entries.each do |error|
        message << "<strong>#{Experiment.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end

  # GET /experiments
  # GET /experiments.xml
  def index

    if !signed_in?
	       flash.now[:notice] = "No Partner found!! Login with authenticated partner credentials!!!"
	       redirect_to samplings_path
    else
   
	    #@experiments = Experiment.all
	    @title = "Microarray experiments"
	  
	 if params[:id].present?

		 logger.warn("#{Time.now} - experiments filtered by: #{params[:id]}")  
	    
		
	   begin
		code_gen = OligoSequence.find_by_id(params[:id]).code
		ol = Oligo.find_all_by_code(code_gen).collect{|p| p.microarraygal_id}

	        @experiments = Experiment.find(:all, :conditions => [ "microarraygal_id IN (?)", ol])
		index_columns ||= [:id,:act,:exp_code,:gal_code,:exp_date,:edit] 
		current_page = params[:page] ? params[:page].to_i : 1
		rows_per_page = params[:rows] ? params[:rows].to_i : 10

                conditions={:page => current_page, :per_page => rows_per_page}
                conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
		    if params[:_search] == "true"
		      conditions[:conditions]=filter_by_conditions(index_columns)
		    end
    

           rescue 		   
                    @experiments = Experiment.find(:all, :conditions => [ "filter_sample_id = ?", params[:id]])     
           end

		    @page_experiments=Experiment.paginate(conditions)
		    total_entries=@page_experiments.total_entries
	    
		    respond_with(@experiments) do |format|
		    format.json { render :json => @experiments.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
		    end        

         else
 
		index_columns ||= [:id,:act,:exp_code,:filter_name,:gal_code,:partner_name,:gpr_code,:exp_date,:mi_image, :check, :edit]
		current_page = params[:page] ? params[:page].to_i : 1
		rows_per_page = params[:rows] ? params[:rows].to_i : 10

		conditions={:page => current_page, :per_page => rows_per_page}
		conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
		    
		if params[:_search] == "true"
		   conditions[:conditions]=filter_by_conditions(index_columns)
		end

		@experiments = Experiment.find(:all, :joins=>[:partner, :filter_sample, :microarraygal])
    
		@page_experiments=Experiment.paginate(conditions)
		total_entries=@page_experiments.total_entries
	    
		    respond_with(@experiments) do |format|
		    format.json { render :json => @experiments.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
		   end
        end
     end
 end
 

    
  # GET /experiments/1
  # GET /experiments/1.xml
  def show
   
  @experiment = Experiment.find(params[:id])
    @title = "Microarray experiments"

  

    if @experiment.nil?
        redirect_to :action => "index"
    end
    @pt = Partner.find(@experiment.partner_id)

    @mg = Microarraygal.find(@experiment.microarraygal_id)
    if @mg.nil?
      flash.now[:error] = "No Microarray .gal file found! create some..."
      redirect_to :action => "index"
    end
     

      respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @experiment }
      format.csv { download_csv }
    end
  end


  # GET /experiments/new
  # GET /experiments/new.xml
  def new
    logger.debug "::::::::::::::::::::microarray experiment create new (" + current_user.name + "):::::::::::::::::::: "
    
    @experiment = Experiment.new
    @title = "Microarray experiments"

    @mg_c = Microarraygal.count()
    if @mg_c.nil? or @mg_c == 0
      flash[:error] = "No microarraygal found! create first someone..."
      redirect_to :action => "index"
      return
    end
  
    @partners = Partner.find(:all)
    @pt = get_partner
    if @pt.nil?
      @mg = Microarraygal.all()
      @gp = Microarraygpr.all()
      @img = MicroArrayImage.all()     
    else
      @mg = Microarraygal.all(:conditions => [ "partner_id = ?", @pt.id])
      @gp = Microarraygpr.all(:conditions => [ "partner_id = ?", @pt.id])
      @img = MicroArrayImage.all(:conditions => [ "partner_id = ?", @pt.id])
      @experiment.partner_id = @pt.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @experiment }
    end
  end

  # GET /experiments/1/edit
  def edit
    @experiment = Experiment.find(params[:id])
    @title = "Microarray experiments"
    @code = @experiment.ecode
  end

  # POST /experiments
  # POST /experimentsxml
  def create
    logger.debug "::::::::::::::::::::microarray experiments create action (" + current_user.name + "):::::::::::::::::::: "
    
     @experiment = Experiment.new(params[:experiment])
    @title = "Microarray experiments"
     
     
    
    @valid = false
    if @experiment.partner.nil?
      flash.now[:error] = "No partner found for this microarray experiments"
      @valid = true
    end

    if @valid
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @experiment.errors, :status => :unprocessable_entity }
      end
      return 
    end

    @pt = get_partner
    @experiment.ecode = get_code(@pt, @experiment.experiment_date, nil)

    @title = "Experiment"

    respond_to do |format|
      if @experiment.save
     

        format.html { 
                    flash[:notice] = 'New experiment is successfully created (You can check the oligos, used in this experiment, by clicking on the "+" sign on individual experiments row!!!)'
                    redirect_to :action => "index"  }
        format.xml  { render :xml => @experiment, :status => :created, :location => @experiment }
      else

        #@partners = Partner.find(:all)
        @codegen = @experiment.code
        @attr_index = 1
        @pt = get_partner

        format.html { render :action => "new" }
        format.xml  { render :xml => @experiment.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /experiments/1
  # PUT /experiments/1.xml
  def update
    @experiment = Experiment.find(params[:id])
    @title = "Microarray experiments"

    respond_to do |format|
      if @experiment.update_attributes(params[:experiment])
        format.html { redirect_to(@experiment, :notice => 'Microarray experiment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @experiment.errors, :status => :unprocessable_entity }
      end
    end
  end

  #Function to initiate analysis of individual or multiple experiments 
  def analyze_experiment
   
    #begin
      data = params['data'].split(",")
      logger.debug "=============================" + data.inspect + "=============================="
   
      if data.size > 1
            data.each do |id|
                @experiment = Experiment.find(id)
                path = get_paths(id)
                @probeNames, @sorted_tsi, @sorted_snr = readGpr(path)
                @micro_array_analysis_file = MicroArrayAnalysisFile.create(experiment_id: @experiment.id, probe: @probeNames, tsi: @sorted_tsi, snr: @sorted_snr)
            end  
      else
	@experiment = Experiment.find(data[0]) 
	path = get_paths(data[0])
            #logger.debug "&&&&&&&&&&&&&&&&&&&&&" + path.to_s + "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
	@probeNames, @sorted_tsi, @sorted_snr = readGpr(path) 
            logger.debug "&&&&&&&&&&&&&&&&&&&&&&&&&&&" + @probeNames.inspect + "@@@@@@@@@@@@@@@@@@@@@@@@"
            logger.debug "&&&&&&&&&&&&&&&&&&&&&&&&&&&" + @sorted_tsi.inspect + "@@@@@@@@@@@@@@@@@@@@@@@@"
	    logger.debug "&&&&&&&&&&&&&&&&&&&&&&&&&&&" + @sorted_snr.inspect + "@@@@@@@@@@@@@@@@@@@@@@@@"	 
            @micro_array_analysis_file = MicroArrayAnalysisFile.create(experiment_id: @experiment.id, probe: @probeNames, tsi: @sorted_tsi, snr: @sorted_snr)


      end  

      respond_to do |format|    
      format.html { redirect_to micro_array_analysis_files_path }
      end    

    #rescue Exception => e

    #  e.message
    #  e.backtrace
      #raise NoGprError, "File does not seem to be GPR formatted. Check the file!!"

    #end   

  end  

  #===================================CALCULATE TSI==========================================================

 #method for parsing gpr file and calculating Total intensities from raw intensities
 def readGpr(file_path)
   begin      
       read = IO.read(file_path)
       #logger.debug read.to_s + "===================================================="

	if !read.valid_encoding?
 	 	read = read.encode("UTF-16be", :invalid=>:replace, :undef => :replace, :replace=>"").encode('UTF-8')
	end

	#read.encode!('UTF-8', :invalid => :replace, :undef => :replace)
	#logger.debug read.to_s + "===================================================="
	read_array = []
	read_array = read.split("\n") 
	#logger.debug read_array.to_s + "===================================================="
    # if read.valid_encoding?
       #read_array = read.split("\n")
  #            
  #      else
  #    read_array = read.encode!("ASCII-8BIT","ASCII-8BIT", invalid: :replace, :undef => :replace).split("\n")
  #      end
      
	mod_array = read_array.map {|e| e.chomp.split("\t")}  
	#logger.debug mod_array.to_s + "================================================"

	element_stabilized = mod_array.map {|element| element.join(",").gsub("\"","").split(",")} 
	#logger.debug element_stabilized.to_s + "===================================================="

	header_removed, column_array = [], []
	if element_stabilized[0].include?("ATF")
		header_removed = element_stabilized.drop_while {|i| i unless i.include?("Block")}
		#logger.debug header_removed.to_s + "===================================================="
	else
		raise NoGprError, "File does not seem to be GPR formatted. Check the file"
	end

	#logger.debug "@#@#@##@#@#@#@#@#@#@#" + header_removed.kind_of?(Array).to_s + "@#@#@##@#@#@#@#@##@#@#@"	

	column_array = header_removed.transpose
	#logger.debug column_array.to_s + "#########################################################"	

	@name, @dia, @f633_mean, @b633_mean = getColumns(column_array)
	@probeNames, @sorted_tsi, @sorted_snr = calTotalSignalIntensity(@name, @dia, @f633_mean, @b633_mean)
               
	return @probeNames, @sorted_tsi, @sorted_snr

    rescue Exception => e
              e.message
              e.backtrace.inspect
    end 

 end 

 def getColumns(array=[])
     name, dia, f633_mean, b633_mean = [], [],[],[]
     begin
         array.map do |element|     
             case
               when element.include?("Name") then name << element
           #logger.debug name.to_s + "++++++++++++++++++++++++++++++++++++++++++++++++++++"
               when element.include?("Dia.") then dia << element

           #logger.debug dia.to_s + "++++++++++++++++++++++++++++++++++++++++++++++++++++"
               when element.include?("F635 Mean") then f633_mean << element
           #logger.debug f633_mean.to_s + "++++++++++++++++++++++++++++++++++++++++++++++++++++"

               when element.include?("B635 Mean") then b633_mean << element  
           #logger.debug b633_mean.to_s + "++++++++++++++++++++++++++++++++++++++++++++++++++++"
     
             end
         end
     
      rescue Exception => e
       e.message
                   e.backtrace.inspect
      end

    return name, dia, f633_mean, b633_mean 
 end

 def calTotalSignalIntensity(probeNameList, diameter, foreground, background)
 
   begin 

       names = probeNameList.flatten
       names.shift
       filterNames = names.uniq 
       #logger.debug dia.to_s + "++++++++++++++++++++++++++++++++++++++++++++++++++++"

        dia = diameter.flatten 
        dia.shift
       #logger.debug dia.to_s + "++++++++++++++++++++++++++++++++++++++++++++++++++++"
        f633 = foreground.flatten
        f633.shift
       #logger.debug f633.to_s + "++++++++++++++++++++++++++++++++++++++++++++++++++++"      
        b633 = background.flatten
        b633.shift
       #logger.debug b633.to_s + "++++++++++++++++++++++++++++++++++++++++++++++++++++"


        names = partition_array(names)
  counts = names.length
  
        R.assign "counts", counts
  for i in 1..names.count
   R.assign "name#{i}", names[i-1]
  end

     #Formula for calculating Total Signal Intensity
     #(F633_mean - B633_mean)*3.14*diameter^2*1/4
     dia = partition_array(dia)
     for i in 1..dia.count
      R.assign "dia#{i}", dia[i-1]
     end
     #R.assign "dia", dia

     f633 = partition_array(f633)
     for i in 1..f633.count
      R.assign "f633#{i}", f633[i-1]
     end
     #R.assign "f633", f633

     b633 = partition_array(b633)
     for i in 1..b633.count
      R.assign "b633#{i}", b633[i-1]
     end
     #R.assign "b633", b633


  R.eval <<-EOF


    mergeVectors <- function(array, counts) {
      for (i in c(1:counts)) {
         if (i == 1) { dummy <- c(get(paste0(array,i))) } 
         else { dummy <- c(dummy, get(paste0(array,i))) }    
       }
      return(dummy)
    }

   names <- mergeVectors("name", counts)
   names <- as.character(names)
   dia <- mergeVectors("dia", counts)
   f633 <- mergeVectors("f633", counts)
   b633 <- mergeVectors("b633", counts)

  calTSI <- function(dia, f633, b633) {
    dia <- as.numeric(dia)
    f633 <- as.numeric(f633)
    b633 <- as.numeric(b633)
    tsi <- (f633 - b633) * 3.14 * dia * dia * 1/4
    return(tsi)
  } 


  calSNR <- function(f633, b633) {
    f633 <- as.numeric(f633)
    b633 <- as.numeric(b633)
    snr <- f633/b633
    return(snr)
  }

  totalSignalIntensities <- calTSI(dia, f633, b633)
  snr <- calSNR(f633, b633)

  names <- as.vector(names)
  totalSignalIntensities <- as.numeric(totalSignalIntensities)
  snr <- as.numeric(snr)	

  tab <- cbind(Name=names, F633=totalSignalIntensities, SNR=snr)
  tab <- data.frame(tab)  
 
  allProbes <- as.character(tab[,1])
  uniqueProbeVec <- unique(allProbes) 
  uniqueProbeVecFilter <- gsub("\357\277\275\357\277\275\357\277\275M", "", uniqueProbeVec)
  print(uniqueProbeVecFilter) 

  meanTSI <- list()
  myData <- list()
  meanSNR <- list()

  for (i in c(1:length(uniqueProbeVec))) {
      
    myData[[i]] <- subset(tab, uniqueProbeVec[i] == tab[ , 1])
  } 

  for (j in c(1:length(uniqueProbeVec))) {

                newVec <- as.numeric(as.character(myData[[j]][, 2]))
                replicate <- as.numeric(length(newVec))
		meanTSI[[j]] <- sum(newVec)/replicate
                

  }

  meanTSI <- unlist(meanTSI)


 for (k in c(1:length(uniqueProbeVec))) {

	snrVec <- as.numeric(as.character(myData[[k]][,3]))
	snrReplicate <- as.numeric(length(snrVec))
	meanSNR[[k]] <- sum(snrVec)/snrReplicate

 }

  meanSNR <- unlist(meanSNR)


   EOF
            
      #passing non UTF-8 char from R to ruby and vice versa throws an error... 
      #"Error in nchar(var) : invalid multibyte string 1". 
      #here is a workaround.
      #Sys.setlocale('LC_ALL','C')
      #http://stackoverflow.com/questions/6669911/error-in-nchar-when-reading-in-stata-file-in-r-on-mac

     #Splitting with in R
     #split(a, ceiling(seq_along(a)/3))

          
            #tsi = R.pull("totalSignalIntensities")
	tsiList = R.pull("meanTSI")
	snrList = R.pull("meanSNR")				
           return filterNames, tsiList, snrList


   rescue Exception => e
        e.message
        e.backtrace.inspect
   end 

 end

 def partition_array(array=[], size=500)
    dummy = []
       begin
    if array.empty?
       raise "Input array is empty!!"
    else
    array.each_slice(size) {|element| dummy.push(element)}
    end
       rescue Exception => e
       e.message
       end     

     return dummy 
 end

      

#==================================INPUT FILE HANDLING============================================

 #method for fetching saved file path based on retrived upload ID from database
 #ID is required to fetch session specific file.
 def get_paths(id)
     #use ID argument to fetch that particular record.
     #with the help of id fetch the file names from database
     @gprId = Experiment.find(id).microarraygpr_id
     @gpr = Microarraygpr.find(@gprId) 
     gpr_title = @gpr.gpr_title
     gpr_dir = @gpr.gpr_dir
     gpr_path = File.join("#{Rails.root}", "#{gpr_dir}", "#{gpr_title}")

     logger.debug "=======================" + gpr_path.to_s + "==========================="

     return gpr_path
 end

#===================================================================================================#

# DELETE /experiments/1
# DELETE /experiments/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to water_types_path
    else

        @experiment = Experiment.find(params[:id])
        @experiment.destroy
        @title = "Microarray experiments"

        respond_to do |format|
          format.html { redirect_to(experiments_url) }
          format.xml  { head :ok }
        end
    end
  end


  private

    def correct_user
      @ex = Experiment.find(params[:id])
      @partner = Partner.find(@ex.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash.now[:notice] = "Only the partner who created the microarray experiment can modify it."
      redirect_to(experiments_path)
    end


   def get_code(partner, pdate, ptype)
      @codegen = ""
      if partner.nil? and not signed_in_and_master?
        return "E??"
      end
      @pid = 1
      unless partner.nil?
        @pid = partner.id
        #2 digits = Nation IT
        #@codegen += partner.country.code.upcase
        #3 or 2 digits -= Partner number, P5 OR P
        @codegen += "E"
        @codegen += "%02d" % partner.fp7_Number
        @codegen += "-"
      else
        if signed_in_and_master?
          @codegen += "ADM"
        else
          @codegen += "E??"
        end
      end

      #4 or 3 = date month and years 1211 OR 121
      ##2011 create increment number by registered date
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
#@cnt = Sampling.calculate(:count, :all, :conditions => ['partner_id =  ? AND samplingDate >= ? AND samplingDate < ? ',  @pid.to_s, Date.today, 1.day.from_now.to_date ])
#@cnt = Sampling.calculate(:count, :all, :conditions => ['code LIKE ? ', '%'+@codegen+'%'])
      @cnt_objs = Experiment.all(:select => "DISTINCT ecode", :conditions => ['ecode LIKE ? ', '%'+@codegen+'%'], :order => 'ecode DESC')
      @cnt = 1 
      if not @cnt_objs.nil? 
          @cnt_obj = @cnt_objs[0] 
          if not @cnt_obj.nil? 
             #P03-110129-xx
             if not @cnt_obj.ecode.nil? 
                @end_str = @cnt_obj.ecode[11..12]
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

      #1 digit organisms b (bacteria) (PTR5)
      #or 1 digit (PTR4) water tyrpe R (river) Lake etc..
      unless ptype.nil?
        @codegen += ptype.to_s
#      else
#        @codegen += "?"
      end

      return @codegen
    end

end
