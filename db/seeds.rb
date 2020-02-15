# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "dev@test.dev",  password: "PasswdTest!", password_confirmation: "PasswdTest!")

(1..5).map {|index| User.create(email: "dev#{index}@test.dev",  password: "PasswdTest!", password_confirmation: "PasswdTest!")}
