class WikisController < ApplicationController

   def index
    @user = current_user
    if @user.premium? || @user.admin?
      @search = Wiki.privately_visable(@user).search(params[:q])
    else
      @search = Wiki.publicly_visable(@user).search(params[:q])
    end
    @wikis = @search.result.paginate(:page => params[:page], per_page: 10)
    @users = User.all
    authorize @wikis
   end

  def new
    @wiki = current_user.wikis.new
    @user = current_user
    authorize @wiki
  end

   def show
    @wiki = Wiki.find(params[:id])
    @user = current_user
   end

   def edit
    @users = User.all
    @wiki = Wiki.find(params[:id])
    authorize @wiki
   end

   def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private,))
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save
      redirect_to @wiki
    else
      redirect_to :back
    end
   end

   def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :public, :private, :user_id))
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki info. Please try again."
      render :edit
      end
    end

    def destroy
     @wiki = Wiki.find(params[:id])
     authorize @wiki
     if @wiki.destroy
      flash[:notice] = "The wiki was removed successfully."
      redirect_to wikis_path
     else
      flash[:error] = "There was an error removing the wiki. Please try again."
      render :show
     end
   end
end