class CommentsController < ApplicationController
  skip_before_action :authorize!, only: [:index]
  before_action :load_article
  # GET /comments
  def index
    comments = serializer.new(@article.comments.page(params[:page]).per(params[:per_page]))

    render json: comments
  end

  # POST /comments
  def create
    @comment = @article.comments.build(
      comment_params.merge(user: current_user)
    )

    @comment.save!
    render json: serializer.new(@comment), status: :created, location: @article
  rescue
    render json: { "errors": @comment.errors }, status: :unprocessable_entity
  end

  private

  def load_article
    @article = Article.find(params[:article_id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:data).require(:attributes).permit(:content) || ActionController::Parameters.new
  end

  def serializer
    CommentSerializer
  end

  def error_serializer
    ErrorSerializer
  end
end
