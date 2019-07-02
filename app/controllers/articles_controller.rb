class ArticlesController < ApplicationController
  skip_before_action :authorize!, only: [:index, :show]

  def index
    articles = serializer.new(Article.recent.page(params[:page]).per(params[:per_page]))
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
