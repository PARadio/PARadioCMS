class Mp3filesController < ApplicationController
  def index
      @mp3files = Mp3file.all
   end

   def new
      @mp3file = Mp3file.new
   end

   def create
      @mp3file = Mp3file.new(mp3file_params)

      if @mp3file.save
        File.open(Rails.root.join('app', 'assets', 'playlist.txt'), 'a+') do |f|
          f.puts "/home/ubuntu/PARadioCMS/public#{@mp3file.attachment_url}"
        end

        redirect_to mp3files_path, notice: "The mp3file #{@mp3file.name} has been uploaded."
      else
         render "new"
      end

   end

   def destroy
      @mp3file = Mp3file.find(params[:id])
      @mp3file.destroy

      # rewrite playlist
      @mp3filesUpdated = Mp3file.all
      File.open(Rails.root.join('app', 'assets', 'playlist.txt'), 'w') do |f|
        @mp3filesUpdated.each do |mp3fileUpdated|
          f.puts "/home/ubuntu/PARadioCMS/public#{mp3fileUpdated.attachment_url}"
        end
      end

      redirect_to mp3files_path, notice:  "The mp3file #{@mp3file.name} has been deleted."
   end

   private
      def mp3file_params
      params.require(:mp3file).permit(:name, :attachment)
   end
end
