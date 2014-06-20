class EditorController < ApplicationController
  protect_from_forgery :except => [:save]
  Save_dir = "/mnt/cloudocs-volume/documents/"

  def index
  end

  def new
    @file_stat = FileStat.new
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

  def create
    attr = params.require(:file_stat).permit(:name)
    @file_stat = FileStat.create(attr)
    @file_stat.path = Save_dir + @file_stat.name
    if @file_stat.save
      begin
        f = open(Save_dir + @file_stat.name, "w")
        f.close
        redirect_to editor_index_path, :notice => "Created!"
      rescue
        FileStat.find(:last, :conditions => {:name => @file_stat.name}).destroy
        flash.now[:notice] = "Failed to create new file entity."
        render "new"
      end
    else
      flash.now[:notice] = "Failed to create new file stat"
      render "new"
    end
  end
end
