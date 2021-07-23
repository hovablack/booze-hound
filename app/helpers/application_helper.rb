module ApplicationHelper
  def login_required
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
