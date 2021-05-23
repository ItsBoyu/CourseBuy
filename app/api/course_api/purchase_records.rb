module CourseApi
  class PurchaseRecords < Grape::API
    helpers AuthenticationHelper
    before { authenticate! }

    resources :courses do
      desc 'User personal purchase records'
      get :purchased do
        courses = current_user.purchased_courses
        present courses, with: Entities::RecordEntity, user: current_user
      end
    end
  end
end