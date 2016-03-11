class CommentsController < ApplicationController

  def edit
    @post = BlogPost.find(params[:blog_post_id])
    @comment = @post.comments.find(params[:id])
  end

  def create
    # Find the post referenced
    @post = BlogPost.find(params[:blog_post_id])

    # Create the new comment with the params
    @comment = @post.comments.new(comment_params)

    # If logged in, attach current user to comment
    if logged_in?
      @comment.user = current_user
    else
      flash.now[:failure] = "Not logged in!"
      render @post
      return
    end

    # Try to save the comment
    if @comment.save
      flash[:success] = 'Comment created!'
      redirect_to @post
    else
      render @post
      return
    end
  end

  def update
    @post = BlogPost.find(params[:blog_post_id])
    @comment = @post.comments.find(params[:id])
    author = @comment.user

    # Check author or admin is logged in
    unless admin? or is_logged_in_user? author
      flash[:danger] = "You aren't an admin or the author!"
      redirect_to @post
      return
    end

    # Try to save the comment
    if @comment.update(comment_params)
      flash[:success] = 'Comment updated!'
      redirect_to @post
    else
      render @post
      return
    end

  end

  def destroy
    # Find the blog post and comment referenced
    @post = BlogPost.find(params[:blog_post_id])
    @comment = @post.comments.find(params[:id])
    author = @comment.user

    # Check author or admin is logged in
    unless admin? or is_logged_in_user? author
      flash[:danger] = "You aren't an admin or the author!"
      redirect_to @post
      return
    end

    # Destroy the comment
    @comment.destroy
    flash[:success] = 'Comment deleted!'

    # Redirect to the article
    redirect_to @post
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
