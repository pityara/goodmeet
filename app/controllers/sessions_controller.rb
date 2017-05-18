class SessionsController < ApplicationController
  skip_before_action :authorized_admin
  skip_before_action :authorized_moderator
  
  def new
  end

  def create
  	user = User.find_by(name: params[:name])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to root_path
  	else 
  		redirect_to login_url, alert: "Неверная комбинация имени и пароля"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: "сеанс работы завершен"
  end
end
