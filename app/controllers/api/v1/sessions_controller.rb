class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if user
      log_in(user)
      render json: UserSerializer.new(user).serializable_hash, status: :ok
    else
      render json: { error: 'Invalid email' }, status: :unauthorized
    end
  end

  def me
    if current_user
      render json: UserSerializer.new(current_user).serializable_hash, status: :ok
    else
      render json: { error: "Not authenticated" }, status: :unauthorized
    end
  end

  def destroy
    log_out
    head :no_content
  end

  private

  def session_params
    params.permit(:email)
  end
end
