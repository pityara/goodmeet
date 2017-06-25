class ProfilesController < ApplicationController
  before_action :set_profile, only: [ :show, :edit, :update, :destroy, :up_rating ]
  before_action :authorized_admin, only: [:up_rating]
  before_action :authorized_moderator, only: [:up_rating]
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
		@profile = Profile.find(params[:id])
	end

	def edit
		@profile = current_user.profile
	end

	def update
		@profile = current_user.profile
		@profile.update(profile_params)
		redirect_to profile_path
	end

  def up_rating
    @profile.increment!(:rating)
    redirect_to admin_path
  end

	def not_my_profile
		@profile = User.find(params[:id]).profile
	end


	private

  def set_profile
      @profile = Profile.find(params[:id])
    end

	def profile_params
      params.require(:profile).permit(:name, :city, :age, :avatar)
    end
end
