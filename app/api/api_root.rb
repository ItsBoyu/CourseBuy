class ApiRoot < Grape::API
  prefix :api
  format :json

  mount CourseApi::Base
  mount Login
end