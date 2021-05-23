module CourseApi
  class Purchase < Grape::API
    helpers AuthenticationHelper
    before { authenticate! }

    resources :courses do
      desc 'User can buy the course'
      params do
        requires :id, type: Integer, desc: 'Course ID which wanna buy.'
      end
      route_param :id do
        post :purchase do
          course = Course.find params[:id]
          order = current_user.orders.new(course: course)
          if order.save
            order
          else
            error!(order.errors.full_messages.join(''), 400)
          end
        end
      end
    end
  end
end