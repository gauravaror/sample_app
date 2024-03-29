class MicropostsController < ApplicationController
before_filter :signed_in_user
before_filter :correct_user , only: :destroy

def create
  @microposts = current_user.microposts.build(params[:micropost])
  if @microposts.save 
    flash[:success] = "Micropost created"
    redirect_to root_url
  else
    @micropost = current_user.microposts.build if signed_in?
    flash[:error] = "Please write some content"
    render 'static_pages/home'
  end
end

def destroy
    @micropost.destroy
    redirect_to root_url
end
  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end


end


