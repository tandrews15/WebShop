class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    set_order
  end

  def feedbacks
   @item = Item.find($item_id)
  end


  def feedbacks_add
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      flash[:success] = "Your feedback has been saved!"
      redirect_to item_path(@feedback.item_id)
    else
      flash[:alert] = "Something went wrong! Your feedback has not been saved."
      redirect_to item_path(@feedback.item_id)
    end   
  end

  # GET /items/1
  # GET /items/1.json
  def show

    set_order

    $item_id = params[:id]
    @item = Item.find($item_id)
    @feedbacks = Feedback.where(item_id: @item.id)

    @feedbacks.each do |feedback|
      @user = User.where(id: feedback.user_id)
    end

    category_list
    feedback_rating
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    
    respond_to do |format|
      if @item.save 
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def set_order

      if Order.where(user_id: current_user.id, confirmed: false).last.present? 
        @order = Order.where(user_id: current_user.id, confirmed: false).last
  
        @counted_ordered_items = OrderedItem.where(order_id: @order.id).count
        else
          order_new = Order.new(shipping_address: current_user.shipping_addres, user_notes: "", shipping_notes: "", confirmed: false, payment_id: 2, user_id: current_user.id)
          order_new.save
          @order = Order.where(user_id: current_user.id, confirmed: false).last
        end
    end


    def count_ordered_items
      order = Order.where(user_id: current_user.id, confirmed: false).last
      @counted_ordered_items = OrderedItem.where(order_id: order.id).count
    end

    def feedback_rating
      rating = 0
      if @feedbacks.count != 0
        number_of_feedbacks = @feedbacks.count
        @feedbacks.each do |feedback|
          rating = feedback.rating + rating
        end
        @rating_avg = rating / number_of_feedbacks
      else
        @rating_avg = "There is no ratings for this item. Be the first!"
      end
    end

    def category_list
      categories = []
      @item.category_items.each do |item|
        categories.push(item.category.name) 
      end
      @result = categories.join(', ')
    end

    def item_params
      params.require(:item).permit(:name, :quantity, :price, :stores_id,
       :photoUrl, :category_ids => [], :feedback_ids => [])
    end

    def feedback_params
      params.permit(:rating, :comment, :user_id, :item_id)
    end
end
