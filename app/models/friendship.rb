class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, presence: true, uniqueness: { scope: :friend_id }
  validates :friend_id, presence: true


  def confirm_friendship
    update(confirmed: true)
    Friendship.create(user_id: friend_id, friend_id: user_id, confirmed: true)
  end

  def destroying_friendship
    if confirmed
      destroy_mutual_friendship
    end
    destroy
  end

  private

  def destroy_mutual_friendship
    Friendship.where('user_id=? AND friend_id=?', friend_id, user_id).find_each{|obj| obj.destroy}
  end
end
