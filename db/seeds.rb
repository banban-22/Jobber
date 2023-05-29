Job.destroy_all()
Review.destroy_all()
User.destroy_all()

100.times do |i|
    j = Job.create(
        created_at: Faker::Date.backward(days: 365),
        title: Faker::Job.title(),
        company: Faker::Company.name(),
        location: Faker::Address.city(),
        description: Faker::Lorem.paragraph(sentence_count: 2),
        view_count: 0,
        saved_count: 0,
        updated_at: Faker::Date.backward(days: 365)
    )

    if j.valid?
        rand(1..5).times do
            Review.create(
                title: Faker::Quotes::Rajnikanth.joke,
                content: Faker::Lorem.sentences(number: 15),
                rating: rand(1..5),
                job_title: Faker::Job.title(),
                location: Faker::Address.city(),
                is_current: Faker::Boolean.boolean(), 
                job: j             
            )
        end
    end
end

admin_user = User.create(
    first_name: "Ayaka",
    last_name: "Bando",
    email: "ayaka@bando.com",
    password: "123abc",
    password_confirmation: "123abc",
    is_admin: true
)

puts Cowsay.say("Generated #{Job.all.count} jobs!", :turtle)
puts Cowsay.say("Generated #{Review.all.count} reviews!", :Ghostbusters)
puts Cowsay.say("Created a user named #{admin_user.first_name}", :kitty)
