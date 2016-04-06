class MediaFilesController < ApplicationController
  def index
      @mediafiles = MediaFile.all
   end

   def new
      @mediafile = MediaFile.new
   end

   def create
      @mediafile = MediaFile.new(mediafiles_params)

      if @mediafile.save
        #File.open(Rails.root.join('app', 'assets', 'playlist.txt'), 'a+') do |f|
        #  f.puts "/home/ubuntu/PARadioCMS/public#{@mediafile.attachment_url}"
        #end

        redirect_to media_files_path, notice: "The media file #{@mediafile.title} has been uploaded."
      else
         render "new"
      end

   end

   def destroy
      @mediafile = MediaFile.find(params[:id])
      @mediafile.destroy

      # rewrite playlist
      #@mp3filesUpdated = MediaFile.all
      #File.open(Rails.root.join('app', 'assets', 'playlist.txt'), 'w') do |f|
      #  @mp3filesUpdated.each do |mp3fileUpdated|
      #    f.puts "/home/ubuntu/PARadioCMS/public#{mp3fileUpdated.attachment_url}"
      #  end
      #end

      redirect_to media_files_path, notice:  "The media file #{@mediafile.title} has been deleted."
   end

   private
      def mediafiles_params
      params.require(:media_file).permit(:title, :attachment)
   end
end
