# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: "yuto@example.com", password: "password")


(1..10).each do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n}@test.com",
    password: "password"
  )
end

users = User.all.limit(5)

users.each do |user|
  (1..rand(1..5)).each do |n|
    list = user.lists.build(
      title: Faker::JapaneseMedia::OnePiece.character,
      caption: Faker::Lorem.paragraph(sentence_count: 6),
    )
    list.image.attach(io: File.open(Rails.root.join("db/fixtures/image_#{rand(1..2)}.jpg")), filename: 'image.jpg')
    sleep(0.5)
    list.save!
  end
end