class EditorController < ApplicationController
  protect_from_forgery :except => [:save]
  Save_dir = "/mnt/cloudocs-volume/documents/"

  def index
    @file_stats = FileStat.find(:all)
  end

  def new
    @file_stat = FileStat.new
  end

  def sign_up
  end
  
  def edit
  	@file = FileStat.find(params[:id])
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
        redirect_to editor_index_path
      rescue
        FileStat.find(:last, :conditions => {:name => @file_stat.name}).destroy
        flash[:notice] = "Failed to create new file entity."
        redirect_to :action => "new"
      end
    else
      case @file_stat.errors.messages.fetch(:name)[0]
      when "has already been taken"
        flash[:notice] = "\"" + @file_stat.name + "\" " + "is already exists." 
      when "is invalid"
        flash[:notice] = "File name must not contain \"\/\"." 
      else
        flash[:notice] = "Failed to create new file stat."
      end
      redirect_to :action => "new"
    end
  end
end
