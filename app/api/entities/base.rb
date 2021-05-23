module Entities
  class Base < Grape::Entity
    format_with(:iso8601) { |dt| dt.iso8601 if dt }
    format_with(:price) { |price| price.format }
  end
end