# coding: utf-8
class Admin::Base < ApplicationController
	before_filter :admin_login_required

	private
	def admin_login_required
		flash.now.alert = "かんりしゃじゃないとダメだよっ！！"
		redirect_to root_path unless @current_user.try(:administrator?)
	end
end
