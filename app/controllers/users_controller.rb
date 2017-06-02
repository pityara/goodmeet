class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :authorized_admin, only: [:update, :destroy, :show, :index]
  before_action :authorized_moderator, only: [:update, :destroy]
  skip_before_action :authorized_user
  # GET /users
  # GET /users.json
  def index
    @users = User.order :name
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.status_id = 3
    Creator.create(user: @user)
        respond_to do |format|
      if @user.save
        @user.profile = Profile.create!(name: "name", age: 0, city: "city", user_id: @user.id)
        session[:user_id] = @user.id
        session[:user_status] = @user.status
        format.html { redirect_to  new_profile_path, notice: 'Вы успешно зарегистрировались!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to users_url, notice: 'Данные о пользователе #{@user.name} успешно обновлены' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :status_id)
    end
end
