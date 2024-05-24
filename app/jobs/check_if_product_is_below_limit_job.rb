class CheckIfProductIsBelowLimitJob < ApplicationJob
  queue_as :default

  def perform
    products = Product.all
    products.each do |product|
      if product.quantity <= 10
        notify_user(product)
      end
    end
  end

  def display_products
    products = Product.all.where(isBelowLimit: true)
  end

  private

  def notify_user(product)
    product.isBelowLimit = true
    product.save
  end
end
