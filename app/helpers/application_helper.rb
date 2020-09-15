module ApplicationHelper
  def can_edit?(goal)
    current_user == goal.user
  end 
end
