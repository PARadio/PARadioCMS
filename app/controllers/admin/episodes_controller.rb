class EpisodesController < ApplicationController
  before_action :require_login
  layout 'main'
  def index
    @episodes = Episode.all
  end
  def all
    @episodes = Episode.all
  end
  def show
    @episode = Episode.find(params[:id])
  end

  def new
    @episode = Episode.new
    @mediafile = Mediafile.new
  end

  def create
    @episode = Episode.new(episode_params)
    @mediafile = @episode.build_mediafile(mediafiles_params)
    Episode.transaction do
      begin
        @episode.mediafile.title=@episode.name.sub(" ", "_").downcase

        if @episode.save
          # set duration attribute
          fullpath = Rails.root.join('public', @episode.mediafile.attachment_url.to_s[1..-1])
          info = Mediainfo.new(fullpath)
          @episode.duration = info.audio.duration/1000
          @episode.save

          flash[:notice]= "Episode created successfully"
          redirect_to(admin_episode_path(@episode))
        else
          render('new')
        end
      rescue ActiveRecord::RecordInvalid
        render('new')
      end
    end
  end

  def edit
    @episode = Episode.find(params[:id])
    @mediafile = @episode.mediafile
  end

  def update
    @episode = Episode.find(params[:id])
    @mediafile = Mediafile.find(@episode.media_id)
    Episode.transaction do
      begin
        @episode.update_attributes(episode_params)
        @mediafile.title=@episode.name.sub(" ", "_").downcase
        @mediafile.update_attributes(mediafiles_params)
      rescue ActiveRecord::RecordInvalid
         render('edit')
      end
    end
    flash[:notice]= "Episode updated successfully"
    redirect_to(admin_episode_path(@episode))
  end

  def delete
    @episode= Episode.find(params[:id])
    @mediafile= @episode.mediafile
  end

  def destroy
    @episode= Episode.find(params[:id]).destroy
    flash[:notice]= "Episode deleted successfully"
    redirect_to({:action=>'index'})
  end

  private
    def episode_params
      params.require(:episode).permit([:name, :description, :transcript, :stage,
        :number])
    end
    def mediafiles_params
      params.require(:mediafile).permit(:attachment)
    end
end
