User.create! name: "Example User", email: "bibi@demo.com",
  password: "123qwe", password_confirmation: "123qwe", admin: true

29.times do |n|
  name = Faker::Name.name
  if n == 0
    email = "example@railstutorial.org"
  else
    email = "bibi#{n+2}@demo.com"
  end
  password = "123qwe"
  User.create! name:  name, email: email,
    password: password, password_confirmation: password
end

users = User.order(:created_at).take 3
20.times do
  content = Faker::Lorem.sentence
  users.each{|user| user.microposts.create! content: content}
end
