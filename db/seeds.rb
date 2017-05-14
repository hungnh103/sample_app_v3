# users
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

# microposts
users = User.all.sample 25
users << User.first unless users.include? User.first
users.each do |user|
  i = rand 10..20
  i.times do
    content = Faker::Lorem.sentence
    created_at = Time.current - (rand 30 + 1).days - (rand 24 + 1).hours - (rand 60 + 1).minutes
    user.microposts.create! content: "#{user.name} - #{content}", created_at: created_at
  end
end

# following relationships
users = User.all
users.each_with_index do |user, index|
  User.where("id <> ?", (index + 1)).sample(rand 5..20).each{|follwer| follwer.follow user}
end
