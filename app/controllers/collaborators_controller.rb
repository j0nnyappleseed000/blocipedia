class CollaboratorsController < ApplicationController

  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators  = Collaborator.all
  end

  def edit
  end

  def new
    @users = User.all
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.new
  end

  def show
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end

end
