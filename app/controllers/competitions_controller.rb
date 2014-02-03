class CompetitionsController < ApplicationController
  # GET /competitions
  def index
    @competitions = Competition.all
  end

  # GET /competitions/:id
  def show
    @competition = Competition.find(params[:id])
  end
end
