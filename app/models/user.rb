class User < ApplicationRecord
	has_secure_password
	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true

	has_many :posts
	has_many :matching_post, class_name: "Post", foreign_key: :match_id

	scope :recent, -> { order(created_at: :desc) }
end
