class TopController < ApplicationController
skip_before_filter :login_required
 def index
   if @current_user 
     redirect_to :controller => "editor", :action => "index"
   end
 end
end
