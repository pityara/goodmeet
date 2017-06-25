class MeetingsController < ApplicationController
  before_action :authorized_admin, only: [:destroy, :edit, :update]
  before_action :authorized_moderator, only: [:destroy, :edit, :update]
  before_action :set_meeting, only: [:show, :edit, :update, :destroy, :participate]

  # GET /meetings
  # GET /meetings.json
  def index
    if session[:user_id]
      @meetings = Meeting.where("required_rating <= ?", User.find(session[:user_id]).profile.rating)
    else
      @meetings = Meeting.all
    end
    @hash = Gmaps4rails.build_markers(@meetings) do |meeting, marker|
      marker.lat meeting.latitude
      marker.lng meeting.longitude
      marker.infowindow meeting.title
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @hash = Gmaps4rails.build_markers(@meeting) do |meeting, marker|
      marker.lat meeting.latitude
      marker.lng meeting.longitude
    end
    @comments = @meeting.comments.page(params[:page] || 1).per(4)
    #render action: :show, layout: request.xhr? == nil
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.creator = Creator.find_by(user: current_user)
    respond_to do |format|
      if @meeting.save
        current_user.meetings << @meeting
        current_user.save
        format.html { redirect_to @meeting, notice: 'Встреча бы успешно создана!' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def participate
    if @meeting.users.exists?(current_user)
      redirect_to @meeting, notice: 'Вы уже учавствуете в этой встрече!'
    else
      @meeting.users << current_user
      redirect_to @meeting, notice: 'Теперь вы учавствуете в этой встрече'
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    render json: { success: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:title, :description, :image, :date, :required_rating, :address)
    end
end
