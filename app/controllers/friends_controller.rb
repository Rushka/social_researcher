class FriendsController < ApplicationController
  before_filter :vk_init, only: [:build, :validate] 
  def index
  end

  def build
    vk = VkontakteApi::Client.new
    render json: {ok: true, response: vk.users.get(uids: 'rushess') }   
  rescue => e
    render json: {ok: false, response: e}
  end

  def validate
    render json: {ok: true, response: vk.users.get(uids: 'rushess') }   
  rescue => e
    render json: {ok: false, response: e}
  end

  private
  def vk_init
    vk = VkontakteApi::Client.new
  end
end
