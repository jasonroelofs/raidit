# From DrNic's Using CoffeeScript in Rails and even on Heroku
desc "Generate cached javascript from coffeescript files"
task :bistro_car => :environment do
   path = "public/javascripts/coffeescripts.js"
   puts "Building *.coffee -> #{path}"

   File.open(path, "w") {|file| file << BistroCar::Bundle.new('default').to_javascript }
end

file "public/javascripts/coffeescript.js" => Dir[File.join(Rails.root, "app/scripts/*.coffee")] do |t|
  Rake::Task["bistro_car"].invoke
end
