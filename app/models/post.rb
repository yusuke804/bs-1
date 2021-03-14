class Post < ApplicationRecord
	validates :title, length: {maximum: 30}
	validates :title, presence: true
	validates :contents, length: {maximum: 400}
	validates :contents, presence: true

	belongs_to :user
end
