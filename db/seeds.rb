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
    Post.create title: Faker::Lorem.sentence, body: ActionController::Base.helpers.simple_format(Faker::Lorem.paragraphs.join('\n\n')), remote_image_url: 'http://lorempixel.com/600/800/people/'
  end

  3.times do |i|
    Post.create title: Faker::Lorem.sentence, body: ActionController::Base.helpers.simple_format(Faker::Lorem.paragraphs.join('\n\n')), remote_image_url: 'http://lorempixel.com/600/800/people/', featured: true
  end
end

# Dummy posts
unless Product.count > 0
  10.times do |i|
    Product.create(
        name: Faker::Lorem.sentence,
        description: ActionController::Base.helpers.simple_format(Faker::Lorem.paragraphs.join('\n\n')),
        remote_image_url: 'https://placeimg.com/600/800/any',
        price: Faker::Number.decimal(4, 2),
        sku: Faker::Lorem.words.join().upcase,
        product_images_attributes: [
            {remote_image_url: 'https://placeimg.com/600/800/any'},
            {remote_image_url: 'https://placeimg.com/600/800/any'},
            {remote_image_url: 'https://placeimg.com/600/800/any'},
            {remote_image_url: 'https://placeimg.com/600/800/any'}
        ]
    )
  end

  6.times do |i|
    Product.create(
        name: Faker::Lorem.sentence,
        description: ActionController::Base.helpers.simple_format(Faker::Lorem.paragraphs.join('\n\n')),
        remote_image_url: 'https://placeimg.com/600/800/any',
        price: Faker::Number.decimal(4, 2),
        sku: Faker::Lorem.words(2).join().upcase,
        featured: true,
        product_images_attributes: [
            {remote_image_url: 'https://placeimg.com/600/800/any'},
            {remote_image_url: 'https://placeimg.com/600/800/any'},
            {remote_image_url: 'https://placeimg.com/600/800/any'},
            {remote_image_url: 'https://placeimg.com/600/800/any'}
        ]
    )
  end
end

# Categories

%w(Sarees Salwars).each { |c| Category.where(name: c).first_or_create }

fabrics_dir = Rails.root.join('seeds', 'fabrics')
Dir.foreach(fabrics_dir) do |item|
  next if item == '.' or item == '..'
  fabric = Fabric.where(name: item.humanize).first_or_create
  if File.directory?(fabrics_dir.to_s+'/'+item)
    Dir.foreach(fabrics_dir.to_s+'/'+item) do |color|
      next if color == '.' or color == '..'
      filepath = Rails.root.join('seeds', 'fabrics', item, color).to_s
      fabric.fabric_colors.create name: color.gsub('.png', '').gsub('-', ' ').humanize, swatch: File.open(filepath)
    end
  end
end

brocades_dir = Rails.root.join('seeds', 'brocade')
Dir.foreach(brocades_dir) do |item|
  next if item == '.' or item == '..'
  filepath = Rails.root.join('seeds', 'brocade', item).to_s
  Brocade.create name: item.gsub('.png', '').gsub('-', ' ').humanize, swatch: File.open(filepath) if File.file? filepath
end
