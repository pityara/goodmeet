class AdminController < ApplicationController
  def index
  	@total_meetings = Meeting.count
  end
end
