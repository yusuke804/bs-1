class Post < ApplicationRecord
	validates :title, length: {maximum: 30}
	validates :title, presence: true
	validates :contents, length: {maximum: 400}
	validates :contents, presence: true

	belongs_to :user
	belongs_to :match, class_name: "User", foreign_key: :match_id

	scope :recent, -> { order(created_at: :desc) }
end
