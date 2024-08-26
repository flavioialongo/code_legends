class Match < ApplicationRecord

  belongs_to :player_1, class_name: 'Match', foreign_key: 'player_1_id'
  belongs_to :player_2, class_name: 'Match', foreign_key: 'player_2_id'

  has_one :room, dependent: :destroy 
  
  after_create :create_room

  validate :players_must_be_different
  private
  
  def create_room
    self.create_room!(uuid: SecureRandom.uuid)
  end

  def players_must_be_different
    if player_1_id == player_2_id
      errors.add(:player_2, 'must be different from Player 1')
    end
  end
end
