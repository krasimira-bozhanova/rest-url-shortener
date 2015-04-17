class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  def index
    links = Link.all
    render :text => links.map(&:id_to_hash).join(','), :status => 200
  end

  # GET /links/id
  def show
    redirect_to @link.url, :status => 301
  end

  # POST /links
  def create
    @link = Link.new(link_params)

    if @link.save
      render :text => @link.id_to_hash, :status => 201
    else
      client_error
    end
  end

  # PUT /links/id
  def update
    if @link.update(link_params)
      render :text => @link.id_to_hash, :status => 200
    else
      client_error
    end
  end

  # DELETE /links/id
  def destroy
    @link.destroy
  end

  # DELETE /links
  def destroy_all
    Link.destroy_all
    render :text => '', :status => 204
  end

  private
    def set_link
      @link = Link.find(params[:id].to_i(36))
    end

    def link_params
      params.permit(:url)
    end

    def client_error
      render :text => "error", :status => 400
    end
end
