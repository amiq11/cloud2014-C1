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
    attr = params.require(:file_stat).permit(:name, :path, :password, :user_id, :private, :last_update)
    @file_stat = FileStat.create(attr)
    if @file_stat.save
      redirect_to editor_index_path, :notice => "Created!"
    else
      render "new"
    end
  end

end
