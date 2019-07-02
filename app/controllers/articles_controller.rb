class ArticlesController < ApplicationController
  skip_before_action :authorize!, only: [:index, :show]

  def index
    articles = serializer.new(Article.recent.page(params[:page]).per(params[:per_page]))
    render json: articles
  end

  def show
    render json: serializer.new(Article.find(params[:id]))
  end

  def create
    article = Article.new(article_params)
    if article.valid?
      article.save
    else
      render json: error_serializer.new(article), status: :unprocessable_entity
    end
  end

  private

  def serializer
    ArticleSerializer
  end

  def error_serializer
    ErrorSerializer
  end

  def article_params
    ActionController::Parameters.new
  end

end
