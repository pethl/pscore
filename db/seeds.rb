# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "********Seeding Data Start************"
User.create("admin"=>true, "email"=>nil, "name"=>"pethl", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"Paul.burnham@accenture.com", "name"=>"paul burnham",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"john.owens@red-zulu.com", "name"=>"john",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"ebostcathyowens@gmail.com", "name"=>"cathy owens", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"andrewcawdery@yahoo.co.uk", "name"=>"andrew cawdery",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"duncanmottram@gmail.com", "name"=>"duncan",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"sparkyrees@yahoo.co.uk", "name"=>"marcus",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"morgankathryn@hotmail.com", "name"=>"kath morgan","style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"krees@darwingray.com", "name"=>"kemps",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"carolineduffy81@hotmail.com", "name"=>"cat", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"tim.dawes@lexisnexis.co.uk", "name"=>"timmy dawes", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"lprice@tesco.net", "name"=>"price",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"mc@mattcant.com", "name"=>"matt cant",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"tjgolding@gmail.com", "name"=>"ty",  "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"matt.s.rees@googlemail.com", "name"=>"matthew rees", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"Andy.davies76@gmail.com", "name"=>"andyd", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"sealn22@yahoo.com", "name"=>"nick seal", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>"billokeefe.planetwales@googlemail.com", "name"=>"bill", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>nil, "name"=>"laurent","style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>nil, "name"=>"rob c","style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>nil, "name"=>"mick d","style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>nil, "name"=>"dommy wuh", "style"=>"old", "wins"=>nil)
User.create("admin"=>false, "email"=>nil, "name"=>"ed burnham", "style"=>"old", "wins"=>nil)
puts "********Seeding Users End************"
puts "********************"
puts "********Seeding Games Start************"
Game.create("current"=>true, "enddate"=>"2014-03-29", "lastyear"=>nil, "name"=>"6 Nations 2014", "startdate"=>"2014-02-01")
Game.create("current"=>nil, "enddate"=>"2013-03-29", "lastyear"=>true, "name"=>"6 Nations 2013", "startdate"=>"2013-02-01")
Game.create("current"=>nil, "enddate"=>"2012-03-29", "lastyear"=>nil, "name"=>"6 Nations 2012", "startdate"=>"2012-02-01")
Game.create("current"=>nil, "enddate"=>"2011-03-29", "lastyear"=>nil, "name"=>"6 Nations 2011", "startdate"=>"2011-02-01")
puts "********Seeding Games End************"
puts "********Seeding Data Start************"
