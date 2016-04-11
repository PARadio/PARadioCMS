class EpisodesController < ApplicationController
  def index
    @episodes = Episode.all
  end

  def show
    @episode = Episode.find(params[:id])
  end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new(episode_params)
    Episode.transaction do
      begin
        @episode.save
        @mediafile.save
      rescue ActiveRecord::RecordInvalid
        render('new')
      end
    end
  end

  def edit
    @episode = Episode.find(params[:id])
  end

  def update
    @episode = Episode.find(params[:id])
    if @episode.update_attributes(episode_params)
      flash[:notice]= "Episode updated successfully"
      redirect_to(episode_path(@episode))
    else
      render('edit')
    end
  end

  def delete
    @episode= Episode.find(params[:id])
  end

  def destroy
    @episode= Episode.find(params[:id]).destroy
    flash[:notice]= "Episode deleted successfully"
    redirect_to({:action=>'index'})
  end

  private
    def episode_params
      params.require(:episode).permit([:name, :description, :transcript, :stage,
        :episode_number])
    end
    def mediafiles_params
      params.require(:mediafile).permit(:title, :attachment)
    end
end
