class Guest<User

  before_validation :generate_guest_username
  def generate_guest_username
    if guest? && username.blank?
      self.username = "Guest_#{SecureRandom.random_number(10000)}"
    end
  end
end