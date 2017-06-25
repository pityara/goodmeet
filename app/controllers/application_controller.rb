class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  	def authorized_admin
  		unless current_user.status_id == 1
  			redirect_to root_path, notice: "У вас нет прав администратора!"
  		end
  	end

  	def authorized_moderator
  		unless current_user.status_id == 1 or current_user.status_id == 2
  			redirect_to root_path, notice: "У вас нет прав модератора!"
  		end
  	end
end
