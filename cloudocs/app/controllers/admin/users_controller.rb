class Admin::UsersController < Admin::Base
 def index
	@users = User.find_all_by_createvalid(false)
 end

 def edit
	@user = User.find(params[:id])
	@user.createvalid = true
	@user.save
        redirect_to :admin_users, notice: "あくせぷとっ！！"
 end

 def destroy
	@user = User.find(params[:id])
	@user.destroy
	redirect_to :admin_users, notice: "りじぇくとっ！！"
 end
end
