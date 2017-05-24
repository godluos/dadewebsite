class Comment < ApplicationRecord
  validates :name, :tel, :email, :description, presence: true
end
