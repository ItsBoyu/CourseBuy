require 'rails_helper'

describe CourseApi::Purchase do
  let(:user) { create(:user) }
  let(:auth_token) { user.auth_token }
  let(:headers) do 
    { 
      'Content-Type' => 'application/json', 
      'Authorization' => auth_token
    }
  end
  let(:course) { create(:course) }
  let(:order) { create(:order, user: user, course: course) }

  describe 'post api/v1/courses/:id/purchase' do
    before { post("/api/v1/courses/#{course.id}/purchase", headers: headers) }
    subject { JSON.parse(response.body) }

    context 'purchase course success' do
      it { expect(response.status).to eq(201) }
      it { expect(subject.keys).to contain_exactly('amount', 'amount_currency', 'created_at', 'expired_at', 'paid_at', 'state') }
    end

    context 'purchase course fail' do
      context 'when purchase the duplicate course' do
        before do
          order.pay!
          post("/api/v1/courses/#{course.id}/purchase", headers: headers) 
        end
        it { expect(response.status).to eq(400) }
        it { expect(subject['error']).to eq('Course is duplicate purchase.') }
      end
      context 'when purchase the course not found' do
        before { post("/api/v1/courses/#{Faker::Number.number(digits: 5)}/purchase", headers: headers) }
        it { expect(response.status).to eq(404) }
        it { expect(subject['error']).to eq('404 RecordNotFound') }
      end
    end
  end
end