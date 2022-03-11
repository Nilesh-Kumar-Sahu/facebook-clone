class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where('confirmed = ?', true) }, through: :friendships

  has_many :sent_requests, -> { where confirmed: false },
           foreign_key: :user_id, class_name: 'Friendship'

  has_many :pending_requests, -> { where(confirmed: false).order(created_at: :desc) },
           foreign_key: :friend_id, class_name: 'Friendship'

  has_many :pending_friends, through: :pending_requests, source: :user
  has_many :likes, dependent: :destroy

  before_save { self.email = email.downcase }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :name, presence: true, length: { maximum: 50 }

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.search(search)
    if search
      User.where('name LIKE ?', "%#{search}%")
    else
      User.all
    end
  end

  def feed
    Post.where('user_id IN (?) OR user_id = ?', friend_ids, id)
  end

  def sent_request?(user)
    sent_requests.where(friend_id: user.id).any?
  end

  def pending_request?(user)
    pending_requests.where(user_id: user.id).any?
  end

  def pending_friends_list
    pending_friends.limit(10)
  end

  def friend?(user)
    friends.include?(user)
  end
end
