namespace :import do
  desc "Import gedcom file into database"
  task :gedcom, [:file, :verbosity]  => :environment do |t, args|
    require_relative '../import/import.rb'
    file = args.file

    i = Import.new do
      @opts = {
        verbosity: args.verbosity.to_i,
        total_lines: File.open(file,"r").readlines.size
      }
    end

    print "Importing Gedcom"
    i.parse(file)
    puts "Done"
    #i.printPeople
  end

  desc "Print help message"
  task :help do
    puts "rake import:gedcom[<path/to/file.ged>, verbosity]"
  end
end
