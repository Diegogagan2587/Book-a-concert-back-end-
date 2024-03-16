require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        post :create, params: { user: { name: 'TestUser' } }
        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)
      end

      it 'returns a success message' do
        post :create, params: { user: { name: 'TestUser' } }
        expect(JSON.parse(response.body)).to include('message' => 'User created successfully')
      end
    end

    context 'with invalid parameters' do
      before { User.create(name: 'ExistingUser') }

      it 'does not create a new user' do
        post :create, params: { user: { name: 'ExistingUser' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(User.count).to eq(1)
      end

      it 'returns an error message' do
        post :create, params: { user: { name: 'ExistingUser' } }
        expect(JSON.parse(response.body)).to include('error' => 'That user already exists')
      end
    end
  end
end
