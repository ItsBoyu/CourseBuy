require 'rails_helper'

describe Login do
  let(:user) { create :user }
  let(:email) { user.email }
  let(:password) { '123456' }
  let(:params) { { email: email, password: password } }

  describe 'post api/v1/sign_in' do
    before do
      post('/api/v1/sign_in', params: params)
    end
    context 'success' do
      it do
        expect(JSON.parse(response.body)['auth_token']).to be_present 
      end
    end

    context 'when with wrong params' do
      context 'without params' do
        before { post('/api/v1/sign_in') }

        it { expect(JSON.parse(response.body)['error']).to eq("email is missing, password is missing") }
      end
      
      context 'with wrong email' do
        let(:email) { 'unvalid@course.com' }

        it { expect(response.status).to eq(401) }
        it { expect(JSON.parse(response.body)['error']).to eq("Access Denied") }
      end
      context 'with wrong password' do
        let(:password) { '111111' }

        it { expect(response.status).to eq(401) }
        it { expect(JSON.parse(response.body)['error']).to eq("Access Denied") }
      end
    end
  end
end
