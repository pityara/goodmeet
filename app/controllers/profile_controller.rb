class ProfileController < ApplicationController
	skip_before_action :authorized_admin
	skip_before_action :authorized_moderator

	def new
		@profile = Profile.new
	end

	def create
		@user = User.find(session[:user_id])
		@profile = Profile.new do |c|
  			c.name = profile_params[:name]
  			c.age = profile_params[:age]
  			c.city = profile_params[:city]
  			c.avatar = profile_params[:avatar]
  			c.user_id = @user.id
		end
		respond_to do |format|
			if @profile.save
        		format.html { redirect_to root_path, notice: 'Вы успешно зарегистрировались!' }
        		format.json { render :show, status: :created, location: @user }
      		else
        		format.html { render :new }
        		format.json { render json: @user.errors, status: :unprocessable_entity }
      		end
  		end
	end


	def show
		@profile = User.find(session[:user_id]).profile
	end

	def edit
		@profile = User.find(session[:user_id]).profile
	end

	def update
		@profile = User.find(session[:user_id]).profile
		@profile.update(profile_params)
		redirect_to profile_path
	end

	def not_my_profile
		@profile = User.find(params[:id]).profile
	end

	
	private

	def profile_params
      params.require(:profile).permit(:name, :city, :age, :avatar)
    end
end
