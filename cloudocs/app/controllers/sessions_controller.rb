# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
skip_before_filter :login_required
  def show
    render "new"
  end

  def create
	user = User.find_by_name params[:name]
	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		redirect_to :controller => 'editor', :action => 'index'
	else
      		flash.now.alert = "もう一度やり直してんなー"
      		render "new"
    	end

  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path

  end

end
