class EditorController < ApplicationController

  Save_dir = "/mnt/cloudocs-volume/documents/"

  def index
  end

  def login
  end

  def new
    @file_stat = FileStat.new
  end

  def sign_up
  end

  def edit
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
