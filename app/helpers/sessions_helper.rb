module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  # Creates a current user
  def current_user
    # 1. If there's a current session user meaning there is an existing session userID:
    if(session[:user_id])
      # 2. Create a current user if not already assigned:
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in_user
    if !logged_in?
      flash[:danger] = "Please log in first"
      redirect_to login_path
    end
  end

  # to test if a user is logged in
  def logged_in?
    !current_user.nil?
  end

  # To test whether the current signed in user is the same user in the link
  def current_user?(user)
    current_user == user
  end
end
