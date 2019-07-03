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
    # current_user is set with the authorize! method in the application controller.
    article = current_user.articles.build(article_params)
    article.save!
      render json: serializer.new(article), status: :created
  rescue
    errors = article.errors
    render json: {"errors": error_serializer.new(errors.to_h)}, status: :unprocessable_entity
  end

  def update
    article = current_user.articles.find(params[:id])
    article = Article.find(params[:id])
    article.update_attributes!(article_params)
    render json: serializer.new(article), status: :ok
  rescue ActiveRecord::RecordNotFound
    authorization_error
  rescue
    errors = article.errors.as_json
    render json: {"errors": errors}, status: :unprocessable_entity
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy
    head :no_content
  rescue
    authorization_error
  end

  private

  def serializer
    ArticleSerializer
  end

  def error_serializer
    ErrorSerializer
  end

  def article_params
    params.require(:data).require(:attributes).permit(:id, :title, :content, :slug) || ActionController::Parameters.new
  end

end
