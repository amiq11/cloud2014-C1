class EditorController < ApplicationController
	protect_from_forgery :except => [:save]

	def index
	end

	def login
	end

	def sign_up
	end

	def edit
		@file = FileStat.find(params[:id])
	end

	def create
	end

	def save
		return redirect_to '/404.html' unless request.xhr?
		@file = FileStat.find(params[:id])
		if params[:body]
			File.open(@file.path, "w") do |file|
				file.write params[:body]
			end
		end
	end
end
