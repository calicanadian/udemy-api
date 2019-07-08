class UserSerializer < ApplicationSerializer
  attributes :login, :password, :avatar_url, :url, :name
end
