class CommentsController < ApplicationController
	skip_before_action :authorized_admin, only: :create
	skip_before_action :authorized_moderator, only: :create
	def create
		@meeting = Meeting.find(params[:meeting_id])
		comment = Comment.new do |c|
  			c.body = comment_params[:body]
  			c.meeting_id = params[:meeting_id]
  			c.user_id = session[:user_id]
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
