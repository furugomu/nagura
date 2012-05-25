class DojosController < ApplicationController
  respond_to :html, :json
  before_filter lambda{ @ranks = Rank.all }, exclude: :index

  def index
    @dojos = Dojo.includes(:rank).all

    respond_with @dojos
  end

  def show
    @dojo = Dojo.find(params[:id])
    respond_with @dojo
  end

  def new
    @dojo = Dojo.new
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end

  def create
    @dojo = Dojo.new(params[:dojo])

    respond_to do |format|
      if @dojo.save
        format.html { redirect_to :dojos, notice: t('successfully created.') }
        format.json { render json: @dojo, status: :created, location: @dojo }
      else
        format.html { render action: "new" }
        format.json { render json: @dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @dojo = Dojo.find(params[:id])

    respond_to do |format|
      if @dojo.update_attributes(params[:dojo])
        format.html { redirect_to :dojos, notice: t('successfully updated.') }
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
