require 'rails_helper'

RSpec.describe Order do
  let(:order){ create :order }

  describe '#pay!' do
    subject { order }
    before { subject.pay! }

    it { expect(subject.expired_at).to be_present }
    it { expect(subject.paid_at).to be_present  }
  end

  describe 'set_amount' do
    subject { order }

    it { expect(subject.amount).to eq subject.course.price }
    it { expect(subject.amount_currency).to eq subject.course.price_currency }
  end

  describe 'validate' do
    context 'when course discontinued' do
      let(:discontinued_course){ create(:course, :discontinued) }
      let(:order){ build(:order, course: discontinued_course) }

      before { order.save }
      it { expect(order.errors.full_messages).to include("Course is discontinued.") }
    end

    context 'when course still available' do
      let(:duplicated){ build(:order, user: order.user, course: order.course) }
      before do
        order.pay!
        duplicated.save
      end

      it { expect(duplicated.errors.full_messages).to include("Course is duplicate purchase.") }
    end
  end
end

