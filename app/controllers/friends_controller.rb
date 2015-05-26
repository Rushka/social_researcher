class FriendsController < ApplicationController
  before_filter :vk_init, only: [:build, :validate] 
  def index
  end

  def build
    render json: {ok: true, response: @vk.users.get(uids: 'rushess') }  
  end

  def validate
    render json: {ok: true, response: @vk.users.get(uids: params[:user]) } 
  rescue => e
    render json: {ok: false, response: e}  
  end

  private
  def vk_init
    @vk = VkontakteApi::Client.new
  end
end
