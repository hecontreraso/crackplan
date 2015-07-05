# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(first_name: "Esteban", last_name: "Contreras", gender: "Male", email: "hecontreraso@gmail.com", password: "12345678")
user = User.create(first_name: "Morcio", last_name: "D'Achiardi", gender: "Male", email: "morcio@morcio.com", password: "12345678")
user = User.create(first_name: "Isabel", last_name: "Ruiz", gender: "Female", email: "iris9112@gmail.com", password: "12345678")
user = User.create(first_name: "Andres", last_name: "Heredia", gender: "Male", email: "andres.heredia@gmail.com", password: "12345678")

event = Event.create(details: "We're going to celebrate the end of angelhack 2015... We are gonna drink some beers!!!", where: "Bogota Beer Company", date: Date.new(2015, 7, 5), time: Time.new(2015, 7, 5, 9, 0, 0))
event = Event.create(details: "We're going to celebrate the end of angelhack 2015... We are gonna drink some beers!!!", where: "Bogota Beer Company", date: Date.new(2015, 7, 5), time: Time.new(2015, 7, 5, 9, 0, 0))
event = Event.create(details: "We're going to celebrate the end of angelhack 2015... We are gonna drink some beers!!!", where: "Bogota Beer Company", date: Date.new(2015, 7, 5), time: Time.new(2015, 7, 5, 9, 0, 0))
event = Event.create(details: "We're going to celebrate the end of angelhack 2015... We are gonna drink some beers!!!", where: "Bogota Beer Company", date: Date.new(2015, 7, 5), time: Time.new(2015, 7, 5, 9, 0, 0))
event = Event.create(details: "We're going to celebrate the end of angelhack 2015... We are gonna drink some beers!!!", where: "Bogota Beer Company", date: Date.new(2015, 7, 5), time: Time.new(2015, 7, 5, 9, 0, 0))
event = Event.create(details: "We're going to celebrate the end of angelhack 2015... We are gonna drink some beers!!!", where: "Bogota Beer Company", date: Date.new(2015, 7, 5), time: Time.new(2015, 7, 5, 9, 0, 0))
event = Event.create(details: "We're going to celebrate the end of angelhack 2015... We are gonna drink some beers!!!", where: "Bogota Beer Company", date: Date.new(2015, 7, 5), time: Time.new(2015, 7, 5, 9, 0, 0))

Assistant.create(event_id: 1, user_id: 1, role: "C")
Assistant.create(event_id: 3, user_id: 1, role: "C")
Assistant.create(event_id: 6, user_id: 2, role: "C")
Assistant.create(event_id: 2, user_id: 3, role: "C")
Assistant.create(event_id: 4, user_id: 3, role: "C")
Assistant.create(event_id: 5, user_id: 3, role: "C")
Assistant.create(event_id: 7, user_id: 3, role: "C")
