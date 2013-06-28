# -*- encoding: UTF-8 -*-
class DojosController < ApplicationController
  respond_to :html, :json
  before_filter lambda{ @ranks = Rank.all }, exclude: :index

  def index
    @dojos = Dojo.includes(:rank).page(params[:page])

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
        format.html { redirect_to :root, notice: t('successfully created') }
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
        format.html { redirect_to :root, notice: t('successfully updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { head :no_content }
    end
  end

  include DojosHelper

  def next_dojo
    if request.referer.try(:start_with?, request.protocol+request.host_with_port)
      render and return
    end

    index = (cookies[:index] || 0).to_i
    @dojo = Dojo.at(index)

    index += 1
    index = 0 unless index < Dojo.count
    cookies[:index] = {value: index.to_s, expires: 1.month.from_now}

    redirect_to battle_check_url(@dojo.mbgaid)
  end
end
