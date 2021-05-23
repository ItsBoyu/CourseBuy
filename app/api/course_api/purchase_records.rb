module CourseApi
  class PurchaseRecords < Grape::API
    helpers AuthenticationHelper, CourseQueryHelper
    before { authenticate! }

    resources :courses do
      desc 'User personal purchase records'
      params do
        optional :category, type: String, desc: 'Specific category filter'
        optional :only_available, type: Boolean, desc: 'Only display available courses or not'
      end
      get :purchased do
        courses = course_query(current_user, params)
        present courses, with: Entities::RecordEntity, user: current_user
      end
    end
  end
end