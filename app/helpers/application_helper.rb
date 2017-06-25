module ApplicationHelper

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
