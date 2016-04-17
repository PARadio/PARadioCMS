class Admin::MediafilesController < ApplicationController
  before_action :require_login
  layout 'main'
  def index
      @mediafiles = Admin::Mediafile.all
   end

   def new
      @mediafile = Admin::Mediafile.new
   end

   def create
      @mediafile = Admin::Mediafile.new(mediafiles_params)

      if @mediafile.save
        #File.open(Rails.root.join('app', 'assets', 'playlist.txt'), 'a+') do |f|
        #  f.puts "/home/ubuntu/PARadioCMS/public#{@mediafile.attachment_url}"
        #end

        redirect_to admin_mediafiles_path, notice: "The media file #{@mediafile.title} has been uploaded."
      else
         render "new"
      end
   end

   def destroy
      @mediafile = Admin::Mediafile.find(params[:id])
      @mediafile.destroy

      # rewrite playlist
      #@mp3filesUpdated = MediaFile.all
      #File.open(Rails.root.join('app', 'assets', 'playlist.txt'), 'w') do |f|
      #  @mp3filesUpdated.each do |mp3fileUpdated|
      #    f.puts "/home/ubuntu/PARadioCMS/public#{mp3fileUpdated.attachment_url}"
      #  end
      #end

      redirect_to admin_mediafiles_path, notice:  "The media file #{@mediafile.title} has been deleted."
   end

   private
      def mediafiles_params
      params.require(:admin_mediafile).permit(:title, :attachment)
   end
end
