# Create roles
roles = [:admin, :user]
roles.each { |r| Role.where(name: r).first_or_create }

users = [
    {name: 'Administrator', email: 'prabhakar@langoor.com', password: 'password', password_confirmation: 'password', tos: '1'}
]

users.each do |details|
  User.where(email: details[:email]).first_or_create details
end

# Attach admin role to first user
User.first.assign_role :admin

pages = ['About Us', 'How it works', 'Help', 'Terms & Conditions', 'Disclaimers', 'Privacy Policy']

pages.each do |title|
  Page.where(title: title).first_or_create body: 'TODO: Write Content'
end

# Dummy posts
unless Post.count > 0
  8.times do |i|
    Post.create title: Faker::Lorem.sentence, body: ActionController::Base.helpers.simple_format(Faker::Lorem.paragraphs.join("\n\n")), remote_image_url: 'http://lorempixel.com/600/800/people/'
  end

  3.times do |i|
    Post.create title: Faker::Lorem.sentence, body: ActionController::Base.helpers.simple_format(Faker::Lorem.paragraphs.join("\n\n")), remote_image_url: 'http://lorempixel.com/600/800/people/', featured: true
  end
end