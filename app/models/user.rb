class User < ApplicationRecord
    # Validazioni
    validates :email, presence: true, uniqueness: true, unless: :guest?
    validates :auth0_id, presence: true, uniqueness: true, unless: :guest?
  
    # Associazioni
    has_many :challenges
    has_one_attached :profile_image
  
    has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: :user_id, dependent: :destroy
    has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: :friend_id, dependent: :destroy
  
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
  
    has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
    has_many :inverse_friends, through: :inverse_friendships, source: :user

    has_many :sent_challenge_requests, class_name: 'ChallengeRequest', foreign_key: 'user_id'
    has_many :received_challenge_requests, class_name: 'ChallengeRequest', foreign_key: 'friend_id'

    def guest?
      guest
    end
  
    def admin?
      is_admin
    end
  
    # Metodo per ottenere la miniatura dell'immagine del profilo
    def profile_image_thumbnail
      profile_image.variant(resize_to_fill: [200, 200]).processed
    end
  end
  