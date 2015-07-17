# Create roles
roles = [:admin, :user]
roles.each { |r| Role.where(name: r).first_or_create }

users = [
    {name: 'Administrator', email: 'prabhakar@langoor.com', password: 'password', password_confirmation: 'password', tos: '1'}
]

users.each do |details|
  unless User.find_by_email details[:email]
    User.create details
  end
end

# Attach admin role to first user
User.first.assign_role :admin

pages = ['About Us', 'How it works', 'Help', 'Terms & Conditions', 'Disclaimers', 'Privacy Policy']

pages.each do |title|
  unless Page.find_by_title title
    Page.create title: title, body: 'TODO: Write Content'
  end
end
