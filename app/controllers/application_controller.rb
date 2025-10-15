class ApplicationController < ActionController::API
  include ActionController::Cookies

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_in(user)
    reset_session
    session[:user_id] = user.id
  end

  def log_out
    reset_session
    @current_user = nil
  end
end
