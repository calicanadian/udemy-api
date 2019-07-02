class AccessTokensController < ApplicationController

  def create
    auth = UserAuthenticator.new(params[:code])
    auth.perform

    render json: serializer.new(auth.access_token), status: :created
  end

  # def index
  #   articles = serializer.new(Article.recent.page(params[:page]).per(params[:per_page]))
  #   render json: articles
  # end

  def serializer
    AccessTokenSerializer
  end

end
