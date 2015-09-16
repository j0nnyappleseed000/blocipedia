class WikisController < ApplicationController
   def index
    @wikis = Wiki.all
   end

   def new
    @wiki = Wiki.new
   end

  #  def show
  #   @wiki = Wiki.find(params[:id])
  #  end

  #  def edit
  #   @wiki = Wiki.find(params[:id])
  #  end

  #  # def create
  #  #  @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :public))
  #  #  if @wiki.save
  #  #    redirect_to @wiki, notice: "New Wiki was created successfully."
  #  #  else
  #  #    flash [:error] = "There was an error creating the new Wiki. Please try again."
  #  #  end
  #  # end

  #  def update
  #   @wiki = Wiki.find(params[:id])
  #   if @wiki.update_attributes(params.require(:topic).permit(:title, :body, :public))
  #     redirect_to @wiki
  #   else
  #     flash[:error] = "Error saving topic. Please try again."
  #     render :edit
  #   end
  # end
end