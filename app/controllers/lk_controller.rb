class LkController < ApplicationController
	skip_before_action :authorized_admin
	skip_before_action :authorized_moderator
  def show
  	@user = User.find(session[:user_id])
  end
end
