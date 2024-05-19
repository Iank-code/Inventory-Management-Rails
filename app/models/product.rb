class Product < ApplicationRecord
    after_create_commit { broadcast_append_to 'products' }
    after_update_commit { broadcast_replace_to 'products' }
    after_destroy_commit { broadcast_remove_to 'products' }

    has_one_attached :image, dependent: :destroy
    validates :name, presence: true
    validates :price, presence: true, numericality:{greater_than: 0}
end
