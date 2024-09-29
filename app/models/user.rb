class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true, unless: :registered?
    validates :email, presence: true, uniqueness: true, unless: :guest?

    def guest?
        self.is_a?(Guest)
    end

    def registered?
        self.is_a?(RegisteredUser)
    end
end
  