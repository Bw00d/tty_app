namespace :db do 
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_microposts		
  end										
end

def make_users
	admin =	User.create!(name: "Example User",
												 email: "Example@railstutorial.org",
												 username: "exampleuser.abc",
												 password: "foobar",
												 password_confirmation: "foobar")
	admin.toggle!(:admin)
	99.times do |n|
		name = Faker::Name.name
		username = (name.split.join.downcase).to_s + ".abc"
		email = "example-#{n+1}@railstutorial.org"
		password = "password"
		User.create!(name: name, username: username, email: email, password: password,
								 password_confirmation: password)	
	end
end

def make_microposts
	users = User.all(limit: 6)
	50.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }
	end		
end


