class FriendsController < ApplicationController
  before_filter :vk_init, only: [:build, :validate] 
  def index
  end

  def build
    render json: {ok: true, response: @vk.users.get(uids: 'rushess') }  
  end

  def validate
    user_id = params[:user1] || params[:user2]
    @vk.users.get(uids: user_id)
    render json: true
  rescue => e
    render json: e
  end

  private
  def vk_init
    @vk = VkontakteApi::Client.new
  end
end
