class CommentsController < ApplicationController
	skip_before_action :authorized_admin, only: :create
	skip_before_action :authorized_moderator, only: :create
	def create
		@meeting = Meeting.find(params[:meeting_id])
		@comment = @meeting.comments.create(comment_params)
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
