module CourseApi
  class Base < Grape::API
    version 'v1', using: :path

    mount Ping
    mount Purchase
    mount PurchaseRecords
  end
end