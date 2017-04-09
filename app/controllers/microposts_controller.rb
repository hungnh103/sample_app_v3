class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # @feed_items = Hash.new
      @feed_items = current_user.feed.paginate page: params[:page], per_page: 5
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = "Micropost deleted!"
    else
      flash[:danger] = "Micropost delete fail"
    end
    redirect_to request.referrer || root_url
    # redirect_back fallback_location: root_url # method was added in Rails 5
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    unless @micropost
      flash[:danger] = "Micropost is not exist"
      redirect_to root_url
    end
  end
end
