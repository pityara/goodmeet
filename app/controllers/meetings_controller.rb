class MeetingsController < ApplicationController
  skip_before_action :authorized_admin, only: [:index, :show, :participate, :new, :create]
  skip_before_action :authorized_moderator, only: [:index, :show, :participate, :new, :create]
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    if session[:user_id]
      @meetings = Meeting.where("required_rating < ?", User.find(session[:user_id]).profile.rating)
    else
      @meetings = Meeting.all
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    $meeting = @meeting
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
    @meeting.creator = Creator.find_by(user: User.find(session[:user_id]))
    respond_to do |format|
      if @meeting.save
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
    $meeting.users << User.find(session[:user_id])
    redirect_to meeting_path($meeting), notice: 'Теперь вы учавствуете в этой встрече'
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:title, :description, :image, :date, :required_rating)
    end
end
