require_relative '../../lib/import/import'

class GedcomImporter < ActiveInteraction::Base
  file :gedcom

  def execute
    import_file(gedcom)
  end

  private

  def import_file(file)
    i = Import.new do
      @opts = {
        total_lines: File.open(file.path, 'r').readlines.size
      }
    end

    i.parse(file.path)
  end
end
