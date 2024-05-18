class Product < ApplicationRecord
    has_one_attached :image, dependent: :destroy

    validates :name, presence: true
end
