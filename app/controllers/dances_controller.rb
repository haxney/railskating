class DancesController < ApplicationController
  # GET /dances
  # GET /dances.json
  def index
    @dances = Dance.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dances }
    end
  end

  # GET /dances/1
  # GET /dances/1.json
  def show
    @dance = Dance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dance }
    end
  end

  # GET /dances/new
  # GET /dances/new.json
  def new
    @dance = Dance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dance }
    end
  end

  # GET /dances/1/edit
  def edit
    @dance = Dance.find(params[:id])
  end

  # POST /dances
  # POST /dances.json
  def create
    @dance = Dance.new(params[:dance])

    respond_to do |format|
      if @dance.save
        format.html { redirect_to @dance, notice: 'Dance was successfully created.' }
        format.json { render json: @dance, status: :created, location: @dance }
      else
        format.html { render action: "new" }
        format.json { render json: @dance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dances/1
  # PUT /dances/1.json
  def update
    @dance = Dance.find(params[:id])

    respond_to do |format|
      if @dance.update_attributes(params[:dance])
        format.html { redirect_to @dance, notice: 'Dance was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @dance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dances/1
  # DELETE /dances/1.json
  def destroy
    @dance = Dance.find(params[:id])
    @dance.destroy

    respond_to do |format|
      format.html { redirect_to dances_url }
      format.json { head :ok }
    end
  end
end
