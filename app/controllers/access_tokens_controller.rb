class AccessTokensController < ApplicationController
  skip_before_action :authorize!, only: :create
  def create
    auth = UserAuthenticator.new(params[:code])
    auth.perform

    render json: serializer.new(auth.access_token), status: :created
  end

  def destroy
    current_user.access_token.destroy
  end

  def serializer
    AccessTokenSerializer
  end

end
