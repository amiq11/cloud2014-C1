class SessionsController < ApplicationController

  def show
    render "new"
  end

  def create
	user = User.find_by_name params[:name]
	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		redirect_to session_path
	else
      		flash.now.alert = "もう一度やり直してんなー"
      		render "new"
    	end

  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to session_path

  end

end
