# frozen_string_literal: true

class Challenge < ApplicationRecord

  has_many :test_cases, dependent: :destroy
  accepts_nested_attributes_for :test_cases, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true

  serialize :input_data, JSON
  serialize :output_data, JSON
  scope :accepted, -> { where(status: 1) }
  scope :rejected, -> { where(status: 0) }
end
