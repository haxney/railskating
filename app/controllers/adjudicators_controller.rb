class AdjudicatorsController < ApplicationController
  # GET /adjudicators
  # GET /adjudicators.json
  def index
    @adjudicators = Adjudicator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adjudicators }
    end
  end

  # GET /adjudicators/1
  # GET /adjudicators/1.json
  def show
    @adjudicator = Adjudicator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adjudicator }
    end
  end

  # GET /adjudicators/new
  # GET /adjudicators/new.json
  def new
    @adjudicator = Adjudicator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adjudicator }
    end
  end

  # GET /adjudicators/1/edit
  def edit
    @adjudicator = Adjudicator.find(params[:id])
  end

  # POST /adjudicators
  # POST /adjudicators.json
  def create
    @adjudicator = Adjudicator.new(params[:adjudicator])

    respond_to do |format|
      if @adjudicator.save
        format.html { redirect_to @adjudicator, notice: 'Adjudicator was successfully created.' }
        format.json { render json: @adjudicator, status: :created, location: @adjudicator }
      else
        format.html { render action: "new" }
        format.json { render json: @adjudicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adjudicators/1
  # PUT /adjudicators/1.json
  def update
    @adjudicator = Adjudicator.find(params[:id])

    respond_to do |format|
      if @adjudicator.update_attributes(params[:adjudicator])
        format.html { redirect_to @adjudicator, notice: 'Adjudicator was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @adjudicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adjudicators/1
  # DELETE /adjudicators/1.json
  def destroy
    @adjudicator = Adjudicator.find(params[:id])
    @adjudicator.destroy

    respond_to do |format|
      format.html { redirect_to adjudicators_url }
      format.json { head :ok }
    end
  end
end
