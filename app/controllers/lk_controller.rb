class LkController < ApplicationController
	skip_before_action :authorized_admin
	skip_before_action :authorized_moderator
  def show
  	@user = User.find(session[:user_id])
  end

  def edit
  end

  private 
      def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :avatar)
    end
end
