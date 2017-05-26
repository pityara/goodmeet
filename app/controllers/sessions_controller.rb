class SessionsController < ApplicationController
  skip_before_action :authorized_user
  
  def new
  end

  def create
  	user = User.find_by(name: params[:name])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
      session[:user_status] = user.status
  		redirect_to root_path
  	else 
  		redirect_to login_url, alert: "Неверная комбинация имени и пароля"
  	end
  end

  def destroy
  	session[:user_id] = nil
    session[:user_status] = nil
  	redirect_to root_url, notice: "Cеанс работы завершен"
  end
end
