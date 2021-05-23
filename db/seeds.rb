category_data = [
  { name: 'business' },
  { name: 'computer_science' },
  { name: 'data_science' },
  { name: 'information_technology' },
  { name: 'social_science' },
  { name: 'arts_and_humanities' }
]

category_data.each do |category|
  object = Category.where(category).first_or_create
  puts "find or create category id: #{object.id}, name: #{object.name}"
end
