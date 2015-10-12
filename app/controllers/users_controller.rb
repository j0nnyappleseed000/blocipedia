class UsersController < ApplicationController

  def index
    @users = User.all
    @wikis = Wiki.paginate(:page => params[:page], per_page: 10)
    #authorize User
  end

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis.paginate(:page => params[:page], per_page: 10)
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
    user = current_user
    user.role = 'standard'
    if user.save!
      redirect_to users_path
    else
    
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end
  
end
