class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    info = user_params

    # info[:avatar] = "test string"

    logger.debug "Params: #{info[:avatar].class}"

    if current_user.update_attributes(info)
      flash[:notice] = "User inforation updated"
    else
      flash[:error] = "Invalid user information"
    end
    redirect_to edit_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
