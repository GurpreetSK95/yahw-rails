class ArticlesController < ApplicationController

  before_action :set_article, only: %i[show edit update destroy]

  def show; end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(get_required_params)
    if @article.save
      flash[:notice] = 'Article was created successfully'
      redirect_to(@article)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @article.update(get_required_params)
      flash[:notice] = 'Article updated successfully'
      redirect_to(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def to_s
    super
    "Title: #{@article.title}, Description: #{@article.description}, Updated at: #{@article.updated_at}"
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def get_required_params
    params.require(:article).permit(:title, :description)
  end
end
