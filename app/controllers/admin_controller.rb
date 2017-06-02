class AdminController < ApplicationController
  def index
  	@total_meetings = Meeting.count
    @users = User.all
  end
end
