class EditorController < ApplicationController
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
    if @file_stat.save
      redirect_to editor_index_path, :notice => "Created!"
    else
      flash.now[:notice] = "Failed to create."
      render "new"
    end
  end

end
