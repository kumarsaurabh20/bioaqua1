class ApplicationController < ActionController::Base
  

   helper :all # include all helpers in all the views, but not in the controllers
  include SessionsHelper #We need the methods from the Sessions helper in both places, so we have to include it explicitly.


   protect_from_forgery
   
end
