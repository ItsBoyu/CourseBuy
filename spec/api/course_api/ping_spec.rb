require 'rails_helper'

describe CourseApi::Ping do
  describe 'get api/v1/ping' do
    before { get('/api/v1/ping') }
    it { expect(JSON.parse( response.body )).to eq 'pong' }
  end
end