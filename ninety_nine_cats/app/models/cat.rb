require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  # freeze ensures that constants are immutable
  CAT_COLORS = %w(black white orange brown).freeze

  validates :birth_date, :color, :name, :sex, :user_id, presence: true
  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)

  has_many :rental_requests,
    class_name: :CatRentalRequest,
    dependent: :destroy

  belongs_to :owner,
    class_name: :User,
    foreign_key: :user_id

  def age
    time_ago_in_words(birth_date)
  end
end

Cat.create!(name: "Joe", color: "black", birth_date: Date.new(2013,2,2), sex: "M",user_id: 1)
