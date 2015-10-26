class CollaboratorsController < ApplicationController

  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators  = @wiki.collaborators
    authorize @collaborators
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
    if @collaborator.save
      flash[:notice] = "Collaborator added successfully"
      redirect_to wiki_collaborators_path(@wiki)
    else
      flash[:error] = "Collaborator added successfully"
      redirect_to new_wiki_collaborator_path(@wiki)
    end
  end

  def destroy
    @collaborator = Wiki.find(params[:id])
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end

end
