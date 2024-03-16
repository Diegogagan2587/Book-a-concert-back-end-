require 'rails_helper'

RSpec.describe ConcertsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    context 'when there are concerts' do
      before do
        User.create(name: 'TestUser')
        Concert.create(
          title: 'TestConcert',
          organizer_id: User.find_by(name: 'TestUser').id,
          description: 'TestDescription',
          img: 'TestImg',
          price: 10.0,
          date: '2021-11-04',
          city: 'TestCity'
        )
      end

      it 'returns all concerts' do
        get :index
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'return the concerts of the current user' do
        get :index
        expect(JSON.parse(response.body).count).to eq(1)
      end
    end
  end
end
