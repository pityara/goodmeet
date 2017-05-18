class ApplicationController < ActionController::Base
  before_action :authorized_admin
  before_action :authorized_moderator
  protect_from_forgery with: :exception

  private
  	def authorized_admin
  		unless session[:user_id] == 1
  			redirect_to root_path, notice: "У вас нет прав администратора!"
  		end
  	end

  	def authorized_moderator
  		unless session[:user_id] == 2
  			redirect_to root_path, notice: "У вас нет прав модератора!"
  		end
  	end
end
