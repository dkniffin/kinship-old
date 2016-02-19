class SourcesController < InheritedResources::Base
  before_action :set_source, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user

  def index
    @sources = Source.all.order(params[:sort]).page(params[:page])
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.create(source_params)

    respond_with(@source)
  end

  def show
  end

  def edit
  end

  def update
    @source.update(source_params)
    respond_with(@source)
  end

  def destroy
    @source.destroy

    respond_with(@source)
  end

  private

  def set_source
    @source = Source.find(params[:id])
  end

  def source_params
    params.require(:source).permit(:title, :url, :citation_body)
  end
end
