class FeedbacksController < ApplicationController

  before_action :set_item_id

  def index
    @feedback = Feedback.all  
  end

  
  def show
  end


  def new 
    @feedback = Feedback.new(feedback_params)
  end

  
  def create
    
  end

  def destroy
    @feedback = Feedback.find(feedback_params)

    @feedback.destroy
  
    flash[:success] = "Comment deleted"
    redirect_to root_path
  end

  private
    def feedback_params
      params.require(:feedback).permit(:rating, :comment)
    end

    def set_item_id
      @item = Item.find(params[:item_id])
    end

end
