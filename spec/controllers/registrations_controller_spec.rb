require 'rails_helper'

describe RegistrationsController do
  describe '#create' do
    subject { post :create, params: params }

    context 'when invalid data provided' do
      let(:params) do
        {
          data: {
            attributes: { login: nil, password: nil }
          }
        }
      end

      it 'should return unprocessable_entity status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error messages in response body' do
        subject
        pp json['errors']
        expect(json['errors']).to include(
          {
            "error" => {
              "login" => "can't be blank",
              "password" => "can't be blank"
            }
          }
        )
      end

      it 'should not create a user' do
        expect{ subject }.not_to change{ User.count }
      end
    end

    context 'when valid data provided' do
      let(:params) do
        {
          data: {
            attributes: { login: 'jsmith', password: 'secretpassword' }
          }
        }
      end
      it 'should rerturn 201 http status code' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'should create a user' do
        expect(User.exists?(login: 'jsmith')).to be_falsey
        expect{ subject }.to change{ User.count }.by(1)
        expect(User.exists?(login: 'jsmith')).to be_truthy
      end
    end
  end
end
