class WikisController < ApplicationController
  helper_method :sort_column, :sort_direction

   def index
    @search = Wiki.search(params[:q])
    @wikis = @search.result.paginate(:page => params[:page], per_page: 10)
    @user = current_user
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
     if @wiki.destroy
      flash[:notice] = "The wiki was removed successfully."
      redirect_to wikis_path
     else
      flash[:error] = "There was an error removing the wiki. Please try again."
      render :show
     end
   end

   private

   def sort_column
    params[:sort] || "title"
   end

   def sort_direction
    params[:direction] || "asc"
   end
end