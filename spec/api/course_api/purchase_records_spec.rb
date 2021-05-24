require 'rails_helper'

describe CourseApi::PurchaseRecords do
  let(:user) { create(:user) }
  let(:auth_token) { user.auth_token }
  let(:headers) do 
    { 
      'Content-Type' => 'application/json', 
      'Authorization' => auth_token
    }
  end
  let(:course) { create(:course) }
  let(:order) { create(:order, user: user) }
  before { create(:order, user: user, state: :expired) }

  describe 'get api/v1/courses/purchased' do
    let(:url) { '/api/v1/courses/purchased' }
    subject { JSON.parse(response.body) }

    context 'search without params' do
      before do
        order.pay!
        get(url, headers: headers)
      end

      it { expect(subject.size).to eq(2) }
      it { expect(subject.first.keys).to contain_exactly('title', 'description', 'category', 'slug', 'orders') }
    end

    context 'search with params' do
      before do
        order.pay! 
        get(url + query, headers: headers)
      end

      context 'with only_available' do
        context 'when it is true' do
          let(:query) { '?only_available=true' }
          it { expect(subject.size).to eq(1) }
          it { expect(subject.first['title']).to eq(order.course.title) }
        end
        context 'when it is false' do
          let(:query) { '?only_available=false' }
          it { expect(subject.size).to eq(2) }
        end
      end

      context 'with category name' do
        context 'when the name match' do
          let(:category) { order.course.category.name }
          let(:query) { "?category=#{category}" }
          it { expect(subject.size).to eq(1) }
          it { expect(subject.first['category']).to eq(category) }
        end
        context 'when the name unmatch' do
          let(:query) { "?category=#{Faker::Lorem.characters(number: 10)}" }
          it { expect(subject.size).to eq(0) }
        end
      end
    end
  end
end