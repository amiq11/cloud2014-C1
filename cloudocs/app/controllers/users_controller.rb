class UsersController < ApplicationController
skip_before_filter :login_required
    def new  
	@user = User.new  
    end  
  
    def create  
    	attr = params.require(:user).permit(:name, :email, :password, :password_confirmation)
	@user = User.create(attr)
    	if @user.save  
      		redirect_to root_path, :notice => "Signed up!"  
    	else  
      		render "new"  
    	end  
    end  
	
end
