ActiveAdmin.register_page "Import" do
  page_action :gedcom, method: :post do
    file = params['gedcom']['file'].tempfile
    GedcomImporter.run!(gedcom: file)
    redirect_to :back, notice: "Import completed"
  end

  content do
    render partial: 'form'
  end
end
