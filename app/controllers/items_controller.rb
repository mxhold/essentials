class ItemsController < ApplicationController
  respond_to :html
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  def index
    @items = Item.order(rating: :desc)
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    flash[:notice] = 'Item successfully created.' if @item.save

    respond_with @item, location: items_url
  end

  # PATCH/PUT /items/1
  def update
    flash[:notice] = 'Item was successfully updated.' if @item.update(item_params)

    respond_with @item
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name)
    end
end
