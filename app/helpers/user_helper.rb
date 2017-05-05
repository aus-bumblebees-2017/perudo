module UserHelper
  def user_logged_in
    @user ||= User.find_by(id: session[:user_id])
  end

end

helpers UserHelper