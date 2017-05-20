class ApplicationController < ActionController::Base
  before_action :authorized_admin
  before_action :authorized_moderator
  protect_from_forgery with: :exception

  private
  	def authorized_admin
  		unless session[:user_status] == "admin" 
  			redirect_to root_path, notice: "У вас нет прав администратора!"
  		end
  	end

  	def authorized_moderator
  		unless session[:user_status] == "admin" or session[:user_status] == "moderator"
  			redirect_to root_path, notice: "У вас нет прав модератора!"
  		end
  	end
end
