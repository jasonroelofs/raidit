desc "Generate cached javascript from coffeescript files"
task :bistro_car => :environment do
   path = "public/javascripts/coffeescripts.js"
   puts "Building *.coffee -> #{path}"

   File.open(path, "w") {|file| file << BistroCar::Bundle.new('default').to_javascript }
end
