class CommentsController < ApplicationController
	before_action :authorized_admin, only: [:destroy, :update]
	before_action :authorized_moderator, only: [:destroy, :update]
	def create
		@meeting = Meeting.find(params[:meeting_id])
		comment = Comment.new do |c|
  			c.body = comment_params[:body]
  			c.meeting = @meeting
  			c.user = current_user
		end
		comment.save
		redirect_to meeting_path(@meeting)
	end

	def destroy
		@meeting = Meeting.find(params[:meeting_id])
		@comment = @meeting.comments.find(params[:id])
		@comment.destroy
		redirect_to meeting_path(@meeting)
	end
	private

		def comment_params
			params.require(:comment).permit(:body)
		end
end
