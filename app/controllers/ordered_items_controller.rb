class OrderedItemsController < ApplicationController
  before_action :set_ordered_item, only: [:show, :edit, :update, :destroy]

  # GET /ordered_items
  # GET /ordered_items.json
  def index

    @users = User.all
    @orders_all = Order.all
    @ordered_items_all = OrderedItem.all

  end

  # GET /ordered_items/1
  # GET /ordered_items/1.json
  def show
  end

  # GET /ordered_items/new
  def new
    @ordered_item = OrderedItem.new
  end

  # GET /ordered_items/1/edit
  def edit
  end

  # POST /ordered_items
  # POST /ordered_items.json
  def create
    ordered_item_from_table = OrderedItem.new(passed_parameters_from_items_index)
    order = Order.where(id: ordered_item_from_table.order_id, confirmed: false, user_id: current_user.id).last
    ordered_item_from_db = OrderedItem.where(order_id: order.id, item_id: ordered_item_from_table.item_id).last
    
    if ordered_item_from_db.present?
      item = Item.where(id: ordered_item_from_db.item_id).last
        if item.quantity > 0
          if ordered_item_from_db.update(quantity: ordered_item_from_db.quantity + 1) && item.update(quantity: item.quantity - 1)
            redirect_to items_path
            flash[:notice] = "Item has been added to your order."
          else
            redirect_to items_path
            flash[:alert] = "Item can not be added to your order."
          end
        else 
          redirect_to items_path
          flash[:alert] = "Item can not be added to your order."
        end
        

    else
      @ordered_item = OrderedItem.new(passed_parameters_from_items_index)
      @item = Item.find(@ordered_item.item_id)

      if @item.quantity > 0
        @item.quantity -= @ordered_item.quantity
        @item.update(quantity: @item.quantity )
        if @ordered_item.save
          redirect_to items_path
          flash[:notice] = "Item has been added to your order."
        else
          redirect_to items_path
          flash[:alert] = "Item can not be added to your order."
        end
        

      else
        flash[:alert] = "Something went wrong! Item was not added to the cart"
        redirect_to items_path
      end

    end
  end
  

  # PATCH/PUT /ordered_items/1
  # PATCH/PUT /ordered_items/1.json
  def update
    
    @quantity_diference = params[:ordered_item][:quantity_new].to_i - params[:old_quantity].to_i
    
    @item = Item.find(@ordered_item.item_id)
    if @item.quantity - @quantity_diference > 0
        @ordered_items = OrderedItem.all
        
        if @ordered_item.update(quantity: @ordered_item.quantity + @quantity_diference) && @item.update(quantity: @item.quantity - @quantity_diference)
          flash[:notice] = "Item quantity has been updated."
          redirect_to items_path
        else
          flash[:alert] = "Something went wrong! Item quantity has not been changed."
          redirect_to ordered_items_path
        end
      
    else
      flash[:alert] = "Item is not available"
      redirect_to items_path
    end
  end

  # DELETE /ordered_items/1
  # DELETE /ordered_items/1.json
  def destroy
    @item = Item.find(@ordered_item.item_id)
    @item.quantity += @ordered_item.quantity
    @item.update(quantity: @item.quantity )
    @ordered_item.destroy
    respond_to do |format|
      format.html { redirect_to ordered_items_url, notice: 'Ordered item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_ordered_item
      @ordered_item = OrderedItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ordered_item_params
      params.require(:ordered_item).permit(:order_id, :item_id, :ordered_item["quantity_new"])
    end
    
    def passed_parameters_from_items_index
      params.permit(:item_id, :quantity, :order_id)
    end

end
