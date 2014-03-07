namespace :export do
  desc "Prints User.all in a seeds.rb way."
  task :seeds_format => :environment do
    User.order(:id).all.each do |user|
      puts "User.create(#{user.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
  desc "Prints Game.all in a seeds.rb way."
  task :seeds_format => :environment do
    Game.order(:id).all.each do |user|
      puts "Game.create(#{user.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end  
end