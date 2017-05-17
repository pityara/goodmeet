class ApplicationController < ActionController::Base
  before_action :authorized_admin
  protect_from_forgery with: :exception

  private
  	def authorized_admin
  		unless session[:user_id] == 1
  			redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"
  		end
  	end
end
