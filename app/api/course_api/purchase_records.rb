module CourseApi
  class PurchaseRecords < Grape::API
    helpers AuthenticationHelper
    before { authenticate! }

    resources :courses do
      desc 'User personal purchase records'
      get :purchased do
        current_user.purchased_records
      end
    end
  end
end