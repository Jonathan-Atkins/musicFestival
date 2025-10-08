class Api::V1::SessionsController < ApplicationController
  def show
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
end
