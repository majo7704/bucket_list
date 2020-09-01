class IdeasController < ApplicationController
  def index
    @search_term=params[:q]
    logger.info("The search term is #{@search_term}")
    @ideas = Idea.search(@search_term)
  end

  def new
    @idea = Idea.new
  end

  def create
    user = User.find(session[:user_id])
    @idea = Idea.new(idea_resource_params)
    @idea.user = user
    if(@idea.save)
      redirect_to ideas_path
    else
      render 'new'
  end
end

  def show
    @idea=Idea.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
    @display_add_comment = session[:user_id].present?
  end

  def edit
    id = params[:id]
    @idea = Idea.find(id)
  end

  def update
    id = params[:id]
    @idea = Idea.find(id)
    if(@idea.update(idea_resource_params))
      redirect_to account_ideas_path
    else
      render 'edit'
  end
end

  private


  def idea_resource_params
    params.require(:idea).permit(:title, :description, :done_count, :photo_url)
  end

end
