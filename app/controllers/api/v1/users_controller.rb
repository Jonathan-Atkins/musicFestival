# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user).serializable_hash, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:first_name, :last_name, :email, :username, :birthday)
  end
end
