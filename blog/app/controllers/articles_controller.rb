class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  # Create a new article
  def create
    # Create a new article model with our creation parameters
    @article = Article.new(article_params)

    # Save the article to the db.
    # On success, redirect to the article.
    # On failure, re-render the new article page
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    # Find the article model with our update parameters
    @article = Article.find(params[:id])
 
    # Update the article in the db.
    # On success, redirect to the article.
    # On failure, re-render the edit article page.
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    # Find the article model with our destroy parameters
    @article = Article.find(params[:id])

    # Destroy the article
    @article.destroy

    # Redirect to the article index
    redirect_to articles_path
  end

  private
    # Define constraints on our input parameters
    def article_params
      params.require(:article).permit(:title, :text)
    end

end