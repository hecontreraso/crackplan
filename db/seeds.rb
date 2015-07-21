# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Public profiles
User.create(privacy: "public", first_name: "Esteban", last_name: "Contreras", gender: "Male", birthdate: Date.new(1991, 11, 26), email: "hecontreraso@gmail.com", password: "12345678")
User.create(privacy: "public", first_name: "Morcio", last_name: "D'Achiardi", gender: "Male", birthdate: Date.new(1992, 6, 26), email: "morcio@morcio.com", password: "12345678")
User.create(privacy: "public", first_name: "Isabel", last_name: "Ruiz", gender: "Female", birthdate: Date.new(1993, 12, 2), email: "iris9112@gmail.com", password: "12345678")
User.create(privacy: "public", first_name: "Andres", last_name: "Heredia", gender: "Male", birthdate: Date.new(1996, 11, 2), email: "andres.heredia@gmail.com", password: "12345678")
User.create(privacy: "public", first_name: "Kung", last_name: "Fury", gender: "Male", birthdate: Date.new(1996, 11, 2), email: "kung.fury@gmail.com", password: "12345678")

# Private profiles
User.create(privacy: "private", first_name: "Tony", last_name: "Stark", gender: "Male", birthdate: Date.new(1984, 06, 16), email: "tony.stark@avengers.com", password: "12345678")
User.create(privacy: "private", first_name: "Captain", last_name: "América", gender: "Male", birthdate: Date.new(1912, 2, 3), email: "captain.america@avengers.com", password: "12345678")
User.create(privacy: "private", first_name: "Bruce", last_name: "Banner", gender: "Male", birthdate: Date.new(1980, 8, 26), email: "hulk@avengers.com", password: "12345678")
User.create(privacy: "private", first_name: "Thor", last_name: "Odinson", gender: "Male", birthdate: Date.new(1978, 3, 17), email: "thor@avengers.com", password: "12345678")
User.create(privacy: "private", first_name: "Natasha", last_name: "Romanoff", gender: "Female", birthdate: Date.new(1928, 8, 28), email: "black.widow@avengers.com", password: "12345678")

Follow.create(follower_id: 1, followed_id: 2, status: :following)
Follow.create(follower_id: 1, followed_id: 3, status: :following)
Follow.create(follower_id: 1, followed_id: 4, status: :following)

# Avengers are following among themselves
Follow.create(follower_id: 6, followed_id: 7, status: :following)
Follow.create(follower_id: 6, followed_id: 8, status: :following)
Follow.create(follower_id: 6, followed_id: 9, status: :following)
Follow.create(follower_id: 6, followed_id: 10, status: :following)

Follow.create(follower_id: 7, followed_id: 6, status: :following)
Follow.create(follower_id: 7, followed_id: 8, status: :following)
Follow.create(follower_id: 7, followed_id: 9, status: :following)
Follow.create(follower_id: 7, followed_id: 10, status: :following)

Follow.create(follower_id: 8, followed_id: 6, status: :following)
Follow.create(follower_id: 8, followed_id: 7, status: :following)
Follow.create(follower_id: 8, followed_id: 9, status: :following)
Follow.create(follower_id: 8, followed_id: 10, status: :following)

Follow.create(follower_id: 9, followed_id: 6, status: :following)
Follow.create(follower_id: 9, followed_id: 7, status: :following)
Follow.create(follower_id: 9, followed_id: 8, status: :following)
Follow.create(follower_id: 9, followed_id: 10, status: :following)

Event.create(creator_id: 1, date: Date.today + 5.days, time: Time.new(2015, 7, 5, 9, 0, 0), created_at: (DateTime.now), image: "1.jpg", details: "We're going to celebrate the end of angelhack 2015... We are gonna drink some beers!!!", where: "Bogota Beer Company")
Event.create(creator_id: 1, date: Date.today + 3.days, time: Time.new(2015, 7, 5, 6, 4, 5), created_at: (DateTime.now - 1.hour), image: "2.jpg", details: "One Day Without Shoes! Don't wear shoes...DO IT!", where: "Madison, Tennessee")
Event.create(creator_id: 1, date: Date.today + 6.days, time: Time.new(2015, 7, 5, 10, 2, 3), created_at: (DateTime.now - 6.hour), image: "3.jpg", details: "fall block party and show!!!!! party starts at 3-6 show @7show is $5 ladies $7 guys comes w/ a complementary CD!! block party is free but game tickets will cost bring extra money… eating contest, prizes, games, free throw contest, pumpkin carving contest, food, haunted house, dunk Rocketown staff Emoticono grin and much more, bring your friends!! click join in!", where: "Rocketown, Nashville, TN")
Event.create(creator_id: 1, date: Date.today + 15.days, time: Time.new(2015, 7, 5, 7, 3, 0), created_at: (DateTime.now - 25.hour), image: "4.jpg", details: "So few of you asked me about it or were interested in martial arts or I think you'd enjoy it Emoticono smile, so lets set a time and date to come as a group or separate, up to you.", where: "2/54 Crittenden Road, Findon, Adelaide, South Australia 5023")
Event.create(creator_id: 2, date: Date.today + 7.days, time: Time.new(2015, 7, 5, 8, 30, 0), created_at: (DateTime.now - 150.hour), image: "5.jpg", details: "Food, Friends, Football and Fun! Giant screen TV's, double tap kegerator, keg-vision, potty-vision, etc. Bring a dish to pass and $ for the pools. Please RSVP!", where: "Krohn House, Ladera Ranch, CA")
Event.create(creator_id: 3, date: Date.tomorrow, time: Time.new(2015, 7, 5, 12, 30, 0), created_at: (DateTime.now - 200.hour), image: "6.jpg", details: "HEY~My friend! June 10 is my birthday,I want to invite u guys to my BD party this Saturday. Come to celebrate with me,I'm really happy to see u on my BD party!", where: "Empire State Building 75th floor")
Event.create(creator_id: 4, date: Date.tomorrow, time: Time.new(2015, 7, 5, 10, 0, 0), created_at: (DateTime.now - 228.hour), image: "7.jpg", details: "Sakura Matsuri, is a 2 day event, the annual cherry blossom festival at BBG, offers over 60 events and performances that celebrate traditional and contemporary Japanese culture. The festival marks the end of Hanami, the Japanese cultural tradition of enjoying each moment of the cherry blossom season.", where: "Brooklyn Botanic Garden 990 Washington Ave, Brooklyn, New York 11225")

Event.create(creator_id: 5, date: Date.today + 6.days, time: Time.new(2015, 7, 5, 9, 0, 0), created_at: (DateTime.now), image: "1.jpg", details: "Avengers meeting", where: "General headquarters")
Event.create(creator_id: 5, date: Date.today + 7.days, time: Time.new(2015, 7, 5, 18, 4, 5), created_at: (DateTime.now - 1.hour), image: "2.jpg", details: "Flying training", where: "NY City")
Event.create(creator_id: 5, date: Date.today + 10.days, time: Time.new(2015, 7, 5, 16, 2, 3), created_at: (DateTime.now - 6.hour), image: "3.jpg", details: "Partyy! hosted by Iron Man", where: "Tony's house")
Event.create(creator_id: 6, date: Date.today + 15.days, time: Time.new(2015, 7, 5, 10, 3, 0), created_at: (DateTime.now - 25.hour), image: "4.jpg", details: "Save the world from Loki", where: "Souvengard")
Event.create(creator_id: 6, date: Date.today + 3.days, time: Time.new(2015, 7, 5, 9, 30, 0), created_at: (DateTime.now - 150.hour), image: "5.jpg", details: "Watch the Avenger's movie! Just to remember old times. In a Giant screen TV's", where: "Captain America house")
Event.create(creator_id: 6, date: Date.today + 2.days, time: Time.new(2015, 7, 5, 15, 30, 0), created_at: (DateTime.now - 200.hour), image: "6.jpg", details: "Hulk birthday!", where: "Avengers Tower, 60th floor")
Event.create(creator_id: 7, date: Date.today + 5.days, time: Time.new(2015, 7, 5, 20, 0, 0), created_at: (DateTime.now - 228.hour), image: "7.jpg", details: "SuperHero official Karts!", where: "New York Karts Pits")
Event.create(creator_id: 7, date: Date.today + 30.days, time: Time.new(2015, 7, 5, 10, 0, 0), created_at: (DateTime.now - 228.hour), image: "7.jpg", details: "Day at the beach.", where: "San Francisco beach")
Event.create(creator_id: 7, date: Date.tomorrow, time: Time.new(2015, 7, 5, 10, 0, 0), created_at: (DateTime.now - 228.hour), image: "7.jpg", details: "Beer pong with super heroes and friends", where: "Mr Doom old headquarters")
Event.create(creator_id: 8, date: Date.tomorrow, time: Time.new(2015, 7, 5, 11, 0, 0), created_at: (DateTime.now - 228.hour), image: "7.jpg", details: "Crossbow training", where: "The arrow guy is guiding us to the place")
Event.create(creator_id: 8, date: Date.tomorrow, time: Time.new(2015, 7, 5, 13, 0, 0), created_at: (DateTime.now - 228.hour), image: "7.jpg", details: "Videogames plan! With blackjack and hookers", where: "Tony's Mansion")
