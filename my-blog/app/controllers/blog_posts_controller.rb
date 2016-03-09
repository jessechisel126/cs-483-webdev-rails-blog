class BlogPostsController < ApplicationController
  def index
    @posts = BlogPost.all
  end

  def show
    @post = BlogPost.find(params[:id])
  end

  def new
    @post = BlogPost.new

    # If nobody logged in, no permission to create
    unless logged_in?
      render '_noperm'
    end
  end

  def edit
    @post = BlogPost.find(params[:id])
    author = User.find(@post.user_id)
    
    # If author is not logged in, no permission to update
    unless is_logged_in_user? author
      render '_noperm'
    end
  end

  def create
    # Create the blog post model with our create parameters
    @post = BlogPost.new(post_params)

    # Double check user is logged in (shouldn't be a problem without hax)
    unless logged_in?
      flash[:danger] = 'Not logged in!'
      redirect_to root_path
    end

    # Try to save the post, redirect if success, re-render if failure
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    # Find the blog post model with our update parameters
    @post = BlogPost.find(params[:id])
    author = User.find(@post.user_id)
    
    # Double check author is logged in
    unless is_logged_in_user? author
      flash[:danger] = 'Author not logged in!'
      redirect_to root_path
    end

    # Try to update the post, redirect if success, re-render if failure
    if @post.update(post_params)
      flash[:success] = 'Post updated!'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    # Find the blog post model with our destroy parameters
    @post = BlogPost.find(params[:id])
    author = User.find(@post.user_id)

    # Double check author or admin is logged in
    unless admin? or is_logged_in_user? author
      flash[:danger] = "You aren't an admin or the author!"
      render 'show'
      return # Needed because of "multiple render" error
    end

    # Destroy the post
    @post.destroy
    flash[:success] = 'Post deleted!'
    redirect_to blog_posts_path
  end

  private
    def post_params
      params.require(:blog_post).permit(:title, :body)
    end
end
