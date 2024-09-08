Like.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

# Create 3 users
3.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password'
  )
end

users = User.all

# Create posts with comments and likes
10.times do
  users.each do |user|
    post = Post.create!(
      title: Faker::Book.title,
      body: "#{Faker::Lorem.sentence(word_count: 8)} #{Faker::Lorem.sentence(word_count: 12)}",
      user: user,
      created_at: Faker::Time.between(from: 60.days.ago, to: Time.now)
    )

    # Generate a random number of comments (between 1 and 5) from other users
    other_users = users.where.not(id: user.id)
    if other_users.any?
      rand(1..5).times do
        commenter = other_users.sample
        Comment.create!(
          body: Faker::Quote.famous_last_words,
          user: commenter,
          post: post,
          created_at: Faker::Time.between(from: post.created_at, to: Time.now)
        )
      end

      # Generate a random number of likes (between 1 and 5) from unique other users
      other_users.sample(rand(1..[other_users.size, 5].min)).each do |liker|
        Like.create!(user: liker, post: post)
      end
    end
  end
end

puts "Seed data created successfully!"
