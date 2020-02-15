class LikesController < ApplicationController
  def create
    current_user.like(shout)
    redirect_to root_path
  end

  private

  def shout
    @_shout ||= Shout.find(params[:id])
  end
end