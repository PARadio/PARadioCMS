class Admin::ShowsController < ApplicationController
  before_action :require_login
  layout 'main'

  def index
    #shows all shows
    @shows = Show.all
  end

  def show
    #shows single show with all shows
    @show= Show.find(params[:id])
  end

  def new
    #shows form to create new show
    @show= Show.new
  end

  def create
    #actually creates the show
    @show = Show.new(show_params)

    @show.user=User.find(session[:user_id])

    if @show.save
      redirect_to admin_show_path(@show), notice: "The show #{@show.name} has been uploaded."
    else
       render "new"
    end
  end

  def edit
    #shows edit form for show
    @show = Show.find(params[:id])
  end

  def update
    #actually updates show
    @show = Show.find(params[:id])

    if @show.update_attributes(show_params)
      flash[:notice]= "Show updated successfully"
      redirect_to(admin_show_path(@show))
    else
      render "edit"
    end
  end

  def delete
    #shows delete confirmation?
  end

  def destroys
    #deletes show
    @show = Show.find(params[:id])
    @show.destroy

    redirect_to admin_show_path, notice:  "The show #{@show.name} has been deleted."
  end
end

private
  def show_params
    params.require(:show).permit([:name, :description, :stage, :user_id])
  end
