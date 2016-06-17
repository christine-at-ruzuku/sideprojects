sample_users = [
  {
    name: "Tim Hooker",
    email: "tim@ruzuku.com",
    password: "password",
    password_confirmation: "password"
  },
  {
    name: "Chrisine Ho",
    email: "christine@ruzuku.com",
    password: "password",
    password_confirmation: "password"
  }
]
sample_users.map do | user |
  User.create!(name:  user[:name],
              email: user[:email],
              password:              user[:password],
              password_confirmation: user[:password_confirmation])   
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
