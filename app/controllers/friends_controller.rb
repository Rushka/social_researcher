class FriendsController < ApplicationController
  before_filter :vk_init, only: [:build, :validate] 
  def index
  end

  def build
    users = @vk.users.get(uids: ['rushess', 'traume'], fields: 'screen_name')
    friends2 = @vk.friends.get(user_id: users.second.uid)
    render json: {ok: true, response: @vk.friends.get(uids: 'rushess') }  
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

  def check_friends(user_ids)
    local_friends = @vk.friends.get(user_id: users.first.uid)
    
    
  end
end
