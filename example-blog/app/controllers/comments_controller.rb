class CommentsController < ApplicationController

  def create
    # Find the article referenced
    @article = Article.find(params[:article_id])

    # Create the new comment with the params
    @comment = @article.comments.create(comment_params)

    # Redirect to the article
    redirect_to article_path(@article)
  end

  def destroy
    # Find the article and comment referenced
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    # Destroy the comment
    @comment.destroy

    # Redirect to the article
    redirect_to article_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end