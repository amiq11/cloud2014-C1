class EditorController < ApplicationController
	def index
	end

	def login
	end

	def sign_up
	end

	def edit
		@file = FileStat.find(params[:id])
		if File.readable? @file.path
		  @body = File.open(@file.path, "r").read
		end
	end

	def create
	end

	def save
		@file = FileStat.find(params[:id])
		if params[:Save]
			File.write(@file.path, params[:text])
		end
		redirect_to :action => "index"
	end

end
