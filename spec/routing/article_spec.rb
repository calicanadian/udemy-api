require 'rails_helper'

describe 'articles routes' do
  let(:article) { create :article }
  it 'should route to articles index' do
    expect(get '/articles').to route_to('articles#index')
  end

  it 'should route to articles show' do
    expect(get "/articles/#{article.id}").to route_to('articles#show', id: "#{article.id}")
  end

  it 'should route to articles create' do
    expect(post '/articles').to route_to('articles#create')
  end

  it 'shoould route to articles update' do
    expect(put "/articles/#{article.id}").to route_to('articles#update', id: "#{article.id}")
    expect(patch "/articles/#{article.id}").to route_to('articles#update', id: "#{article.id}")
  end

  it 'should route to articles destroy' do
    expect(delete "/articles/#{article.id}").to route_to('articles#destroy', id: "#{article.id}")
  end
end
