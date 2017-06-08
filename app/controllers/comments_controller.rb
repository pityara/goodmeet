class CommentsController < ApplicationController
	before_action :authorized_admin, only: [:destroy, :update]
	before_action :authorized_moderator, only: [:destroy, :update]


	def create
		@meeting = Meeting.find(params[:meeting_id])
		@comment = Comment.new do |c|
  			c.body = comment_params[:body]
  			c.meeting = @meeting
  			c.user = current_user
		end
		respond_to do |format|
			if @comment.save
				format.js
			end
		end
	end

	def destroy
		@meeting = Meeting.find(params[:meeting_id])
		@comment = @meeting.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.js
		end
	end
	private

		def comment_params
			params.require(:comment).permit(:body)
		end
end
