class ApplicationController < ActionController::Base
  before_action :authorized_user
  protect_from_forgery with: :exception

  private

    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end

    def authorized_user
      unless current_user
        redirect_to login_path, notice: "Зарегистрируйтесь или войдите!"
      end
    end

  	def authorized_admin
  		unless current_user.status == "admin" 
  			redirect_to root_path, notice: "У вас нет прав администратора!"
  		end
  	end

  	def authorized_moderator
  		unless current_user.status == "admin" or current_user.status == "moderator"
  			redirect_to root_path, notice: "У вас нет прав модератора!"
  		end
  	end
end
