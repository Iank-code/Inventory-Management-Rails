class ApplicationController < ActionController::Base
    helper_method :getNumberOfProducts
    helper_method :belowLimitProducts
    helper_method :checkIfIsBelowLimit

    def checkIfIsBelowLimit
        @products = Product.all
        @products.each do |product|
            if product.quantity <= 10
                product.isBelowLimit = true

                product.save
            end

            if product.quantity > 10
                product.isBelowLimit = false

                product.save
            end
        end
    end

    def getNumberOfProducts
        @allProducts = Product.all.length()
        @allProducts
    end

    def belowLimitProducts
        @allProducts = Product.all.where( isBelowLimit: true)
        @allProducts
    end
end
