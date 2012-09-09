5.times do
  u = User.new({
    :email => Faker::Internet.email,
    :name => Faker::Name.name,
    :password => 'secret',
    :password_confirmation => 'secret',
  })

  u.confirmed_at = Time.now
  u.save!
end