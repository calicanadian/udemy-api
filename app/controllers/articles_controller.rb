class ArticlesController < ApplicationController

  def index
    articles = serializer.new(Article.recent)
    render json: articles
  end

  def show
    render json: serializer.new(Article.find(params[:id]))
  end

  private

  def serializer
    ArticleSerializer
  end

end
