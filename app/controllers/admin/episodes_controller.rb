class Admin::EpisodesController < ApplicationController
  before_action :require_login
  layout 'main'
  def index
    @episodes = Admin::Episode.all
  end

  def show
    @episode = Admin::Episode.find(params[:id])
  end

  def new
    @episode = Admin::Episode.new
    @mediafile = Admin::Mediafile.new
  end

  def create
    @episode = Admin::Episode.new(episode_params)
    @mediafile = @episode.build_mediafile(mediafiles_params)
    Admin::Episode.transaction do
      begin
        @episode.mediafile.title=@episode.name.sub(" ", "_").downcase
        @episode.user_id= session[:user_id]
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
    @episode = Admin::Episode.find(params[:id])
    @mediafile = @episode.mediafile
  end

  def update
    @episode = Admin::Episode.find(params[:id])
    @mediafile = Admin::Mediafile.find(@episode.media_id)
    Admin::Episode.transaction do
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
    @episode= Admin::Episode.find(params[:id])
    @mediafile= @episode.mediafile
  end

  def destroy
    @episode= Admin::Episode.find(params[:id]).destroy
    flash[:notice]= "Episode deleted successfully"
    redirect_to({:action=>'index'})
  end

  private
    def episode_params
      params.require(:admin_episode).permit([:name, :description, :transcript, :stage,
        :number])
    end
    def mediafiles_params
      params.require(:admin_mediafile).permit(:attachment)
    end
end
