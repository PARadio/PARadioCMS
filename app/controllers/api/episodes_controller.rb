class Api::EpisodesController < ApplicationController
  def index
    @episodes= Episode.all 
  end
end
