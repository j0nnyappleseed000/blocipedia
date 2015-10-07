class WikisController < ApplicationController

   def index
    if current_user
      @wikis = Wiki.visible_to(current_user).paginate(:page => params[:page], per_page: 10)
    else
      @wikis = Wiki.paginate(:page => params[:page], per_page: 10)
    end
    @user = current_user
    authorize @wikis
   end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

   def show
    @wiki = Wiki.find(params[:id])
    @user = current_user
   end

   def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
   end

   def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :public))
    authorize @wiki
    if @wiki.save
      redirect_to @wiki
    else
    
    end
   end

   def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :public))
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
end