namespace :import do
  desc "Import gedcom file into database"
  task :gedcom, [:file, :verbosity]  => :environment do |t, args|
    require_relative '../import/import.rb'
    file = args.file
    verbosity = args.verbosity.to_i || 0
    i = Import.new(verbosity)
    i.parse(file)
  end

  desc "Print help message"
  task :help do
    puts "rake import:gedcom[<path/to/file.ged>, verbosity]"
  end
end
