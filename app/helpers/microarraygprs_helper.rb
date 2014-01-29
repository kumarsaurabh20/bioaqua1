module MicroarraygprsHelper

#fix for invalid byte sequence in UTF-8 error
#http://stackoverflow.com/questions/2982677/ruby-1-9-invalid-byte-sequence-in-utf-8
#http://robots.thoughtbot.com/fight-back-utf-8-invalid-byte-sequences
#line = line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
#added in all the methods below


  def auth_ma_user(maid)
	    @mag = Microarraygpr.find(maid)
	    return auth_user(@mag.partner_id)
  end  


  def extract_gpr_info
       name = Microarraygpr.find(params[:id]).gpr_title
       directory = "public/Microarraygprs/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
       line = line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')   
       #f = File.open(path)      
       #f.each do |line|
            if line =~  /(^ATF.*\s+.+$\n)/m 
            return "#{$1}"  
           end
  end












end
