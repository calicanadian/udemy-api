class AccessTokensController < ApplicationController
  skip_before_action :authorize!, only: :create
  def create
    auth = UserAuthenticator.new(authentication_params)
    auth.perform

    render json: serializer.new(auth.access_token), status: :created
  end

  def destroy
    current_user.access_token.destroy
  end

  def serializer
    AccessTokenSerializer
  end

  private

  def authentication_params
    params.permit(:code).to_h.symbolize_keys
  end

end
