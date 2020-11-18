5.times do
  User.create(
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678'
  )
end

users = User.order(:created_at).take(5)
20.times do
  title = Faker::Lorem.words
  body = Faker::Lorem.sentence
  users.each { |user| user.boards.create(title: title, body: body) }
end