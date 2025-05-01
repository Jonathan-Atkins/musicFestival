# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      user.create_schedule
      render json: UserSerializer.new(user).serializable_hash, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def find
    user = User.find_by_email(params[:email])
    if user
      render json: UserSerializer.new(user).serializable_hash, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:first_name, :last_name, :email, :username, :birthday)
  end
end
