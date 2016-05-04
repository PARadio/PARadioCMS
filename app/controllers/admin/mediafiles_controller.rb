class Admin::MediafilesController < ApplicationController
  before_action :require_login
  layout 'main'
  def index
      @mediafiles = Mediafile.all
   end

   def new
      @mediafile = Mediafile.new
   end

   def create
      @mediafile = Mediafile.new(mediafiles_params)

      if @mediafile.save
        redirect_to admin_mediafiles_path, notice: "The media file #{@mediafile.title} has been uploaded."
      else
         render "new"
      end
   end

   def destroy
      @mediafile = Mediafile.find(params[:id])
      @mediafile.destroy

      redirect_to admin_mediafiles_path, notice:  "The media file #{@mediafile.title} has been deleted."
   end

   private
      def mediafiles_params
      params.require(:admin_mediafile).permit(:title, :attachment)
   end
end
