class CollaboratorsController < ApplicationController

  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators  = @wiki.collaborators
    authorize @collaborators
  end

  def edit
  end

  def new
    @wiki = Wiki.find(params[:wiki_id]) # finds wiki from params
    @collaborator = @wiki.collaborators.new # creates new collaborator for wiki
    @collaborators = @wiki.collaborators # sets existing wiki collaborators
    @users = User.all_except(@collaborators) # sets users without current_user
  end

  def show
  end

  def create
    if Collaborator.exists?(collaborator_params[:user_id])
      redirect_to new_wiki_collaborator_path(@wiki)
    else
      @wiki = Wiki.find(params[:wiki_id])
      @collaborator = @wiki.collaborators.build(collaborator_params)
        if @collaborator.save
          flash[:notice] = "Collaborator added successfully"
          redirect_to wiki_collaborators_path(@wiki)
        else
        flash[:error] = "There was an error adding the collaborator. Please try again."
        redirect_to new_wiki_collaborator_path(@wiki)
      end
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "The collaborator was removed successfully."
      redirect_to wiki_collaborators_path
     else
      flash[:error] = "There was an error removing the collaborator. Please try again."
      render :show
     end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end

end
