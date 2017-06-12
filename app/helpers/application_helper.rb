module ApplicationHelper
	def current_user
		User.find(session[:user_id]) if session[:user_id]
	end

	def admin?
		if current_user
			if current_user.status_id == 1
				true
			else
				false
			end
		end
	end

	def moder?
		if current_user
			if current_user.status_id == 2
				true
			else
				false
		end
	end
end
end
