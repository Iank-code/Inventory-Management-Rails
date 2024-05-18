require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "Should not save without name" do
    product = Product.new
    assert_not product.save, "Saved the product without name"
  end
end
