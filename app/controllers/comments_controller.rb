class CommentsController < ApplicationController
before_action :ensure_authenticated

def create 
  @comment = Comment.new comment_params
  idea = Idea.find(params[:idea_id])
  @comment.idea = idea
  #associate comment with a user
  @comment.user = current_user
  @comment.save!
end

private

def comment_params
  params.require(:comment).permit(:body)
end

end