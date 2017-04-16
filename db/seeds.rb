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

users = User.order(:created_at).take 5
20.times do
  content = Faker::Lorem.sentence
  created_at = Time.current - (rand 30 + 1).days - (rand 24 + 1).hours - (rand 60 + 1).minutes
  users.each{|user| user.microposts.create! content: "#{user.name} - #{content}", created_at: created_at}
end
