class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
    @search_term=params[:q]
    logger.info("The search term is #{@search_term}")
  end

  def new
    
  end

  def create
    idea = Idea.new
    idea.title = params[:title]
    idea.save!
    redirect_to ideas_index_path
  end
end
