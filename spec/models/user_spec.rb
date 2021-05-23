require 'rails_helper'

RSpec.describe User do
  let(:user){ create :user }

  describe '#renew_token!' do
    it 'change auth_token' do
      old_token = user.auth_token
      user.renew_token!
      expect(user.reload.auth_token).not_to eq old_token
    end
  end
end

