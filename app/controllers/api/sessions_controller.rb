class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])

    if @user
      login(@user)
      render :create
    else
      render json: ["Invalid Credentials"], status: 422
    end
  end


  def destroy
    # debugger
    if logged_in?
      logout
      render json: {}
    else
      render json: ["Not logged in"], status: 404
    end

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
