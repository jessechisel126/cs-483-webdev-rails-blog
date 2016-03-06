# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Need to create the parent of all admins, since creating 
# new admins requires an admin to be currently signed in
# NOTE: password must be changed after seeding for security
@user = User.create(username: 'admin', password: 'password', type: 'Administrator')