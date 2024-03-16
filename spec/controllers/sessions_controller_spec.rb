require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'logs in an existing user' do
        User.create(name: 'TestUser')
        post :create, params: { name: 'TestUser' }
        expect(response).to have_http_status(:ok)
        expect(User.find_by(name: 'TestUser').logged).to eq(true)
      end
    end

    context 'with invalid parameters' do
      it 'does not log in a nonexistent user' do
        post :create, params: { name: 'TestUser' }
        expect(response).to have_http_status(:not_found)
        expect(User.find_by(name: 'TestUser')).to eq(nil)
      end
    end
  end
end
