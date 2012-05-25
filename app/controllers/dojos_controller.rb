class DojosController < ApplicationController
  respond_to :html, :json

  def index
    @dojos = Dojo.all

    respond_with @dojos
  end

  # GET /dojos/1
  # GET /dojos/1.json
  def show
    @dojo = Dojo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dojo }
    end
  end

  # GET /dojos/new
  # GET /dojos/new.json
  def new
    @dojo = Dojo.new
    @ranks = Rank.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dojo }
    end
  end

  # GET /dojos/1/edit
  def edit
    @dojo = Dojo.find(params[:id])
  end

  # POST /dojos
  # POST /dojos.json
  def create
    @dojo = Dojo.new(params[:dojo])

    respond_to do |format|
      if @dojo.save
        format.html { redirect_to @dojo, notice: 'Dojo was successfully created.' }
        format.json { render json: @dojo, status: :created, location: @dojo }
      else
        format.html { render action: "new" }
        format.json { render json: @dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dojos/1
  # PUT /dojos/1.json
  def update
    @dojo = Dojo.find(params[:id])

    respond_to do |format|
      if @dojo.update_attributes(params[:dojo])
        format.html { redirect_to @dojo, notice: 'Dojo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dojos/1
  # DELETE /dojos/1.json
  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy

    respond_to do |format|
      format.html { redirect_to dojos_url }
      format.json { head :no_content }
    end
  end
end
