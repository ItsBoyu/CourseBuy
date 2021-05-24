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

Category.all.each do |category|
  5.times do |t|
    category.courses.first_or_create(
      title: "#{category.name}#{t}",
      slug: "#{category.name}#{t}",
      status: Course.statuses.keys.sample,
      price: rand(5000..20000),
      period: rand(1..30)
    )
  end
end
