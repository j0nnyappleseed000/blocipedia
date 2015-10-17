class UsersController < ApplicationController

  def index
    @users = User.all
    #authorize User
  end

  def show
    @user = User.find(params[:id])
    @priwikis = Wiki.privately_visable(@user)
    @pubwikis = Wiki.publicly_visable(@user)
    #authorize @user
  end

  def update
    @user = User.find(params[:id])
    #authorize @user
    current_user.update_attributes!(role: 'premium')
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def downgrade
    wikis = Wiki.all
    user = current_user
    user.role = 'standard'
    current_user.wikis.where(:private => true).update_all(:private => false)
    if user.save!

      redirect_to users_path
    else
      flash[:error] = "There was an error downgrading your user. Please try again."
      redirect_to edit_user_registration_path
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end
  
end
