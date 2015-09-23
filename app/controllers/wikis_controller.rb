class WikisController < ApplicationController

   def index
    @wikis = Wiki.all
    @user = current_user
   end

  def new
    @wiki = Wiki.new
  end

   def show
    @wiki = Wiki.find(params[:id])
    @user = current_user
   end

   def edit
    @wiki = Wiki.find(params[:id])
   end

   def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :public))
    if @wiki.save
      redirect_to @wiki
    else
    
    end
   end

   def update
    @wiki = Wiki.find(params[:id])
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