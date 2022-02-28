class User < ApplicationRecord
    has_many :posts, dependent: :destroy

    before_save {self.email = email.downcase}

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    validates :name, presence: true, length: {maximum: 50}


    def feed
        Post.where("user_id = ?", id)
    end
end
